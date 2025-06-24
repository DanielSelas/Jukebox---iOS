import UIKit
import FirebaseDatabase
import AVFoundation

class LibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    var songs: [Song] = []
    var shuffled: Bool = false
    var originalSongs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
          tableView.delegate = self
          tableView.dataSource = self
          titleLabel.text = "My Library"

          shuffleButton.tintColor = .systemGray
          shuffleButton.backgroundColor = .clear
          shuffleButton.layer.cornerRadius = 8

          fetchSongs()
    }

    func fetchSongs() {
        let ref = Database.database().reference().child("Library")
        ref.observeSingleEvent(of: .value) { snapshot in
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

            // מיון לפי A-Z בלי תלות באותיות גדולות
            self.originalSongs = loadedSongs.sorted {
                $0.title.lowercased() < $1.title.lowercased()
            }
            self.songs = self.originalSongs
            self.tableView.reloadData()
        }
    }

    // MARK: - Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = songs[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LibrarySongCell", for: indexPath) as? LibrarySongCell else {
            fatalError("Failed to dequeue LibrarySongCell")
        }

        cell.songNameLabel.text = song.title
        cell.artistLabel.text = song.artist
        cell.durationLabel.text = formatTime(song.duration)

        if let url = URL(string: song.imageURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.songImageView.image = image
                    }
                }
            }
        }

        return cell
    }

    // MARK: - Play / Shuffle

    @IBAction func playAllTapped(_ sender: UIButton) {
        playSongsInNowPlaying(with: songs)
    }

    @IBAction func shuffleTapped(_ sender: UIButton) {
        shuffled.toggle()
        if shuffled {
            songs.shuffle()
            shuffleButton.tintColor = .systemBlue
            shuffleButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        } else {
            songs = originalSongs
            shuffleButton.tintColor = .systemGray
            shuffleButton.backgroundColor = UIColor.clear
        }
        tableView.reloadData()
    }

    func playSongsInNowPlaying(with songsToPlay: [Song]) {
        let playlist = Playlist(name: "My Library", imageName: "", songs: songsToPlay)

        guard let tabBarController = self.tabBarController,
              let viewControllers = tabBarController.viewControllers else { return }

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
    }

    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
