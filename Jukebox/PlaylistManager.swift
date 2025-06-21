

class PlaylistManager {
    static let shared = PlaylistManager()
       private(set) var playlists: [Playlist] = []

       func addPlaylist(_ playlist: Playlist) {
           playlists.append(playlist)
       }

       func getPlaylist(named name: String) -> Playlist? {
           return playlists.first { $0.name == name }
       }
}
