import Foundation


class Song {
    let title: String
    let artist: String
    let imageURL: String
    let duration: TimeInterval
    let audioURL: String
    
    init(title: String, artist: String, imageURL: String, duration: TimeInterval, audioURL: String) {
        self.title = title
        self.artist = artist
        self.imageURL = imageURL
        self.duration = duration
        self.audioURL = audioURL
    }
}


extension Song {
    func toDictionary() -> [String: Any] {
        return [
            "title": title,
            "artist": artist,
            "imageURL": imageURL,
            "duration": duration,
            "audioURL": audioURL
        ]
    }
}
