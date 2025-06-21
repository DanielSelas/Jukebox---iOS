import Foundation
import FirebaseDatabase

class Playlist {
    var id: String? 
    var name: String
    var imageName: String
    var songs: [Song]

    init(id: String? = nil, name: String, imageName: String, songs: [Song] = []) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.songs = songs
    }

    func addSong(_ song: Song) {
        songs.append(song)
        saveToFirebase()
    }

    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "imageName": imageName,
            "songs": songs.map { $0.toDictionary() }
        ]
    }

    func saveToFirebase() {
        let ref = Database.database().reference().child("playlists")
        if let id = id {
            // Update existing playlist
            ref.child(id).setValue(self.toDictionary())
        } else {
            // New playlist
            let newRef = ref.childByAutoId()
            newRef.setValue(self.toDictionary())
            self.id = newRef.key
        }
    }
}
