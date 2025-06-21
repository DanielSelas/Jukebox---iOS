import UIKit

class PlaylistDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var songs: [Song] = []
    
    @IBOutlet weak var playlistNameLabel: UILabel!
    var playlistName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playlistNameLabel.text = playlistName
        playlistNameLabel.textAlignment = .center
              playlistNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = songs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)

        // תמונת אלבום - tag 1
        if let albumImageView = cell.viewWithTag(1) as? UIImageView {
            albumImageView.image = nil
            if let url = URL(string: song.imageURL) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url),
                       let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            albumImageView.image = image
                        }
                    }
                }
            }
        }

        // שם השיר - tag 2
        if let titleLabel = cell.viewWithTag(2) as? UILabel {
            titleLabel.text = song.title
        }

        // שם האמן - tag 3
        if let artistLabel = cell.viewWithTag(3) as? UILabel {
            artistLabel.text = song.artist
        }

        // משך הזמן - tag 4
        if let durationLabel = cell.viewWithTag(4) as? UILabel {
            durationLabel.text = formatDuration(song.duration)
        }

        return cell
    }

    func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
