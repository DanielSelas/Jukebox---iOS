import UIKit

class PlaylistCell: UITableViewCell {
    
    @IBOutlet weak var playlistImageView: UIImageView!
    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var numberOfSongsLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var expandButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupStyle()
    }
    
    private func setupStyle() {
        playlistImageView.layer.cornerRadius = 8
        playlistImageView.clipsToBounds = true
        
        playlistNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        numberOfSongsLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        numberOfSongsLabel.textColor = .gray
        
        playButton.tintColor = .white
        playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        playButton.imageView?.contentMode = .scaleAspectFit
        playButton.contentHorizontalAlignment = .fill
        playButton.contentVerticalAlignment = .fill
        
        expandButton.setTitle("Details", for: .normal)
        expandButton.setTitleColor(.systemBlue, for: .normal)
        expandButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
}
