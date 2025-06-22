import UIKit
import FirebaseDatabase
import AVFoundation

class NowPlayingViewController: UIViewController{
    
    @IBOutlet weak var marqueeScrollView: UIScrollView!
    @IBOutlet weak var marqueeLabel: UILabel!
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var maxVolButton: UIButton!
    
    var audioPlayer: AVPlayer?
    
    var isPlaying = false
    var currentSongIndex = 0
//    var songs: [Song] = []
    
    @IBOutlet weak var playlistTitleLabel: UILabel!
    var playlist: Playlist?
    var songs: [Song] {
        return playlist?.songs ?? []
    }
    
    let timerManager = SongTimerManager()
    var currentTime: TimeInterval = 0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

          progressView.transform = CGAffineTransform(scaleX: 1.0, y: 0.2)
          volumeSlider.value = 1.0

          do {
              try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
              try AVAudioSession.sharedInstance().setActive(true)
          } catch {
              print("⚠️ Audio session error: \(error)")
          }

          print("📀 NowPlaying loaded with playlist: \(playlist?.name ?? "nil")")
          
          if let name = playlist?.name {
              playlistTitleLabel.text = "Now Playing: \(name)"
          }

          if !songs.isEmpty {
              currentSongIndex = 0
              updateNowPlaying()
          } else {
              print("❌ No songs in playlist")
          }

        
        
        //Database initate
//        let seeder = SongSeeder()
//        seeder.seedSongs()
        

//        loadSongsFromDatabase()
        
    }
    
    // MARK: - Load all song in data base
    
//    func loadSongsFromDatabase() {
//        let dbRef = Database.database().reference()
//        dbRef.child("Library").observeSingleEvent(of: .value) { snapshot in
//            var loadedSongs: [Song] = []
//            
//            for child in snapshot.children {
//                if let snap = child as? DataSnapshot,
//                   let dict = snap.value as? [String: Any],
//                   let title = dict["title"] as? String,
//                   let artist = dict["artist"] as? String,
//                   let imageURL = dict["imageURL"] as? String,
//                   let duration = dict["duration"] as? Int,
//                   let audioURL = dict["audioURL"] as? String{
//                    
//                    let song = Song(title: title, artist: artist, imageURL: imageURL, duration: TimeInterval(duration), audioURL: audioURL)
//                    loadedSongs.append(song)
//                }
//            }
//            
//            self.songs = loadedSongs
//            self.currentSongIndex = 0
//            self.updateNowPlaying()
//        }
//    }
    
    // MARK: - Song player
    
    func playSong(from urlString: String, fromTime: TimeInterval = 0) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)

        let targetTime = CMTime(seconds: fromTime, preferredTimescale: 1)
        audioPlayer?.seek(to: targetTime, toleranceBefore: .zero, toleranceAfter: .zero) { _ in
            self.audioPlayer?.play()
        }
    }
    
    func updateNowPlaying() {
        
        guard !songs.isEmpty else {
              print("❌ No songs to play")
              return
          }
        
        let song = songs[currentSongIndex]
        
        if let playlistName = playlist?.name {
              playlistTitleLabel.text = "Now Playing : \(playlistName)"
          }
        
        marqueeLabel.layer.removeAllAnimations()
        marqueeLabel.text = "\(song.artist) – \(song.title)"
        marqueeLabel.sizeToFit()
        
        albumImageView.image = nil
        loadImage(from: song.imageURL)
        
        timerManager.reset()
        
        currentTimeLabel.text = formatTime(0)
        durationLabel.text = formatTime(song.duration)
        progressView.progress = 0.0
        
        if isPlaying {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.animateMarqueeLoop()
            }
            setupTimer()
        }
    }
    
    
    
    // MARK: - Nav buttons for songs
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        isPlaying.toggle()
            
            if isPlaying {
                sender.setImage(UIImage(systemName: "pause.circle"), for: .normal)
                print("Playing song: \(songs[currentSongIndex].title)")
                
                animateMarqueeLoop()
                setupTimer()
                
                playSong(from: songs[currentSongIndex].audioURL, fromTime: currentTime)
                
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               usingSpringWithDamping: 0.6,
                               initialSpringVelocity: 0.8,
                               options: [],
                               animations: {
                    self.albumImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                })
                
            } else {
                sender.setImage(UIImage(systemName: "play.circle"), for: .normal)
                print("⏸ Paused")
                
                marqueeLabel.layer.removeAllAnimations()
                
                let scrollViewWidth = marqueeLabel.superview?.bounds.width ?? 0
                let labelWidth = marqueeLabel.intrinsicContentSize.width
                let centeredX = (scrollViewWidth - labelWidth) / 2
                marqueeLabel.frame.origin.x = centeredX
                
                currentTime = timerManager.currentTime
                timerManager.stop()
                audioPlayer?.pause()
                
                UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseInOut]) {
                    self.albumImageView.transform = .identity
                }
            }
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        timerManager.reset()
           audioPlayer?.pause()
           audioPlayer = nil
           currentTime = 0
           currentSongIndex = (currentSongIndex + 1) % songs.count
           updateNowPlaying()
           
           if isPlaying {
               playSong(from: songs[currentSongIndex].audioURL, fromTime: 0)
           }
    }
    
    @IBAction func previousTapped(_ sender: UIButton) {
        timerManager.reset()
            audioPlayer?.pause()
            audioPlayer = nil
            currentTime = 0
            currentSongIndex = (currentSongIndex - 1 + songs.count) % songs.count
            updateNowPlaying()
            
            if isPlaying {
                playSong(from: songs[currentSongIndex].audioURL, fromTime: 0)
            }    }
    
    
    
    // MARK: - Song name and Artist name
    
    func animateMarqueeLoop() {
        guard let scrollView = marqueeLabel.superview else { return }
        
        let scrollWidth = scrollView.bounds.width
        let labelWidth = marqueeLabel.intrinsicContentSize.width
        
        marqueeLabel.frame = CGRect(x: scrollWidth, y: marqueeLabel.frame.origin.y, width: labelWidth, height: marqueeLabel.frame.height)
        
        let totalDistance = scrollWidth + labelWidth
        let duration = Double(totalDistance) / 40.0  // מהירות – אפשר לשנות
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear, .repeat], animations: {
            self.marqueeLabel.frame.origin.x = -labelWidth
        }, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateMarqueeLoop()
    }
    
    
    // MARK: - Song Duration and time moving
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func setupTimer() {
        let song = songs[currentSongIndex]
        
        timerManager.onTick = { current, total in
            self.currentTimeLabel.text = self.formatTime(current)
            self.durationLabel.text = self.formatTime(total)
            
            self.progressView.progress = Float(current / total)
        }
        
        timerManager.onSongEnded = {
            self.nextTapped(self.nextButton)
        }
        
        timerManager.start(from: currentTime, duration: song.duration)
    }
    
    // MARK: - Image handler
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.albumImageView.image = image
                    self.setBackgroundColor(from: image)
                }
            }
        }
    }
    
    func setBackgroundColor(from image: UIImage) {
        guard let averageColor = image.averageColor else { return }
        
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = averageColor.withAlphaComponent(0.8)
        }
    }
    
    
    // MARK: - Volume handler
    @IBAction func volumeChanged(_ sender: UISlider) {
        audioPlayer?.volume = sender.value
    }
    
    @IBAction func muteTapped(_ sender: UIButton) {
        audioPlayer?.volume = 0.0
        volumeSlider.value = 0.0
    }
    @IBAction func fullVolTapped(_ sender: UIButton) {
        audioPlayer?.volume = 1.0
        volumeSlider.value = 1.0
    }
    
}


    extension UIImage {
        var averageColor: UIColor? {
            guard let inputImage = CIImage(image: self) else { return nil }
            let extent = inputImage.extent
            let context = CIContext(options: nil)
            let parameters = [kCIInputExtentKey: CIVector(cgRect: extent)]
            guard let filter = CIFilter(name: "CIAreaAverage", parameters: parameters) else { return nil }
            filter.setValue(inputImage, forKey: kCIInputImageKey)

            guard let outputImage = filter.outputImage else { return nil }

            var bitmap = [UInt8](repeating: 0, count: 4)
            context.render(outputImage,
                           toBitmap: &bitmap,
                           rowBytes: 4,
                           bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                           format: .RGBA8,
                           colorSpace: CGColorSpaceCreateDeviceRGB())

            return UIColor(red: CGFloat(bitmap[0]) / 255.0,
                           green: CGFloat(bitmap[1]) / 255.0,
                           blue: CGFloat(bitmap[2]) / 255.0,
                           alpha: 1)
        }
    }
    
