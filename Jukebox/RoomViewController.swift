import UIKit
import FirebaseDatabase

class RoomViewController: UIViewController{
    
    @IBOutlet weak var addSong: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var dbRef: DatabaseReference!
    var songs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Song from RealtimeDB
        dbRef = Database.database().reference()
        
        //Table View
        tableView.delegate = self
        tableView.dataSource = self
        
        //               observeSongs()
    }
    
    
    // Add Song to DB
    @IBAction func addSongTapped(_ sender: UIButton) {
        let song = [
            "title": "Let It Happen",
            "artist": "Tame Impala"
        ]
        
        dbRef.child("songs").childByAutoId().setValue(song) { error, _ in
            if let error = error {
                print("❌ Error saving song: \(error.localizedDescription)")
            } else {
                print("✅ Song saved successfully!")
            }
        }
    }
    
    
    
    
    //    func observeSongs() {
    //        dbRef.child("songs").observe(.value) { snapshot in
    //            var newSongs: [Song] = []
    //
    //            for child in snapshot.children {
    //                if let snap = child as? DataSnapshot,
    //                   let dict = snap.value as? [String: Any],
    //                   let title = dict["title"] as? String,
    //                   let artist = dict["artist"] as? String {
    //                    newSongs.append(Song(title: title, artist: artist, imageName: image ))
    //                }
    //            }
    //
    //            self.songs = newSongs
    //            self.tableView.reloadData()
    //        }
    //    }
}
    
    extension RoomViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return songs.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let song = songs[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
            cell.textLabel?.text = "\(song.title) by \(song.artist)"
            return cell
         
        }
    }
    
    
    
