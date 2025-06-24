import UIKit
import FirebaseDatabase

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var playlists: [Playlist] = []
    var allSongs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        loadPlaylistsAndSongs()
    }
    
    // MARK: - Load Playlists
    
    func loadPlaylistsAndSongs() {
        let dbRef = Database.database().reference()
        
        dbRef.child("playlists").observeSingleEvent(of: .value) { snapshot in
            var loadedPlaylists: [Playlist] = []
            
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let name = dict["name"] as? String,
                   let imageName = dict["imageName"] as? String {
                    
                    var songs: [Song] = []
                    if let songDicts = dict["songs"] as? [[String: Any]] {
                        for songDict in songDicts {
                            if let title = songDict["title"] as? String,
                               let artist = songDict["artist"] as? String,
                               let imageURL = songDict["imageURL"] as? String,
                               let duration = songDict["duration"] as? TimeInterval,
                               let audioURL = songDict["audioURL"] as? String {
                                let song = Song(title: title, artist: artist, imageURL: imageURL, duration: duration, audioURL: audioURL)
                                songs.append(song)
                            }
                        }
                    }
                    
                    let playlist = Playlist(name: name, imageName: imageName, songs: songs)
                    loadedPlaylists.append(playlist)
                }
            }
            
            self.playlists = loadedPlaylists
            print("✅ Loaded \(self.playlists.count) playlists")
            self.loadSongsAndDistribute()
        }
    }
    
    // MARK: - Load Songs
    
    func loadSongsAndDistribute() {
        let dbRef = Database.database().reference().child("Library")
        
        dbRef.observeSingleEvent(of: .value) { snapshot in
            var loadedSongs: [Song] = []
            
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let title = dict["title"] as? String,
                   let artist = dict["artist"] as? String,
                   let imageURL = dict["imageURL"] as? String,
                   let duration = dict["duration"] as? Int,
                   let audioURL = dict["audioURL"] as? String {
                    
                    let song = Song(title: title, artist: artist, imageURL: imageURL, duration: TimeInterval(duration), audioURL: audioURL)
                    loadedSongs.append(song)
                }
            }
            
            self.allSongs = loadedSongs
            print("Loaded \(self.allSongs.count) songs from Firebase")
            self.distributeSongsToPlaylists()
        }
    }
    
    // MARK: - Distribute songs across playlists
    func distributeSongsToPlaylists() {
        guard !allSongs.isEmpty else { return }
        guard !playlists.isEmpty else { return }
        
        for playlist in playlists {
            playlist.songs.removeAll()  // Clean before refill
        }
        
        for (i, song) in allSongs.enumerated() {
            let index = i % playlists.count
            playlists[index].addSong(song)
        }
        
        print("Distributed songs into playlists")
        
        savePlaylistsToFirebase()
        tableView.reloadData()
    }
    
    // MARK: - Save updated playlists to Firebase
    
    func savePlaylistsToFirebase() {
        let ref = Database.database().reference().child("playlists")
        ref.removeValue { error, _ in
            guard error == nil else {
                print("❌ Failed to clear playlists: \(error!.localizedDescription)")
                return
            }
            
            for playlist in self.playlists {
                let dict = playlist.toDictionary()
                ref.childByAutoId().setValue(dict)
            }
            
            print("Playlists saved to Firebase")
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playlist = playlists[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath) as! PlaylistCell
        
        cell.playlistNameLabel.text = playlist.name
        cell.numberOfSongsLabel.text = "\(playlist.songs.count) songs"
        
        if let url = URL(string: playlist.imageName),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            cell.playlistImageView.image = image
        } else {
            cell.playlistImageView.image = UIImage(named: "defaultPlaylistImage")
        }
        
        cell.playButton.tag = indexPath.row
        cell.expandButton.tag = indexPath.row
        
        cell.playButton.addTarget(self, action: #selector(playPlaylist(_:)), for: .touchUpInside)
        cell.expandButton.addTarget(self, action: #selector(expandPlaylist(_:)), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: - Button Actions
    
    @objc func playPlaylist(_ sender: UIButton) {
        var playlist = playlists[sender.tag] 
        playlist.songs.shuffle()

        print("🎵 Playing shuffled playlist: \(playlist.name) with \(playlist.songs.count) songs")

        guard let tabBarController = self.tabBarController,
              let viewControllers = tabBarController.viewControllers else {
            print("❌ Tab bar controller or view controllers not found")
            return
        }

        for vc in viewControllers {
            if let navVC = vc as? UINavigationController,
               let nowPlayingVC = navVC.viewControllers.first as? NowPlayingViewController {
                nowPlayingVC.playlist = playlist
                nowPlayingVC.currentSongIndex = 0
                nowPlayingVC.updateNowPlaying()
                tabBarController.selectedViewController = navVC
                return
            }

            if let nowPlayingVC = vc as? NowPlayingViewController {
                nowPlayingVC.playlist = playlist
                nowPlayingVC.currentSongIndex = 0
                nowPlayingVC.updateNowPlaying()
                tabBarController.selectedViewController = nowPlayingVC
                return
            }
        }

        print("❌ NowPlayingViewController not found in tab bar")
    }
    
    @objc func expandPlaylist(_ sender: UIButton) {
        let playlist = playlists[sender.tag]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "PlaylistDetailViewController") as? PlaylistDetailViewController {
            
            detailVC.modalPresentationStyle = .pageSheet
            detailVC.songs = playlist.songs
            detailVC.playlistName = playlist.name
            
            if let sheet = detailVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
            }
            
            present(detailVC, animated: true)
        }
    }
}
