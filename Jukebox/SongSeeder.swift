import FirebaseDatabase

class SongSeeder {
    private let dbRef = Database.database().reference()
    
    func seedSongs() {
        let songs = [
            
            Song(title: "Let It Happen",
                 artist: "Tame Impala",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b2739e1cfc756886ac782e363d79",
                 duration: 257,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Tame%20Impala%20-%20Let%20It%20Happen%20(Official%20Video).mp3"),
           
            Song(title: "Lose Yourself",
                 artist: "Eminem",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b27376ac6f4b5e6cda3c7f888ec0",
                 duration: 321,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Eminem%20-%20Lose%20Yourself%20(Lyrics).mp3"),
          
            Song(title: "Blinding Lights",
                 artist: "The Weeknd",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b2738863bc11d2aa12b54f5aeb36",
                 duration: 200,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/The%20Weeknd%20-%20Blinding%20Lights%20(Lyrics).mp3"),
          
            Song(title: "BLUE",
                 artist: "Billie Eilish",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b27371d62ea7ea8a5be92d3c1f62",
                 duration: 344,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Billie%20Eilish%20-%20BLUE%20(Official%20Lyric%20Video).mp3"),
            
            Song(title: "Dang!",
                 artist: "Mac Miller feat. Anderson .Paak",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b2732e92f776279eaf45d14a33fd",
                 duration: 279,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Mac%20Miller%20-%20Dang!%20(feat.%20Anderson%20.Paak).mp3"),
            
            Song(title: "Abracadabra",
                 artist: "Lady Gaga",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b273b0860cf0a98e09663c82290c",
                 duration: 245,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Lady%20Gaga%20-%20Abracadabra%20(Official%20Audio).mp3"),
            
            Song(title: "Von dutch",
                 artist: "Charli xcx ",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b27388e3822cccfb8f2832c70c2e",
                 duration: 165,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Charli%20xcx%20-%20Von%20dutch.mp3"),
            
            Song(title: "DENIAL IS A RIVER",
                 artist: "Doechii",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b273b245099fe26319344ddf6054",
                 duration: 160,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Doechii%20-%20DENIAL%20IS%20A%20RIVER%20(Audio).mp3"),
            
            Song(title: "Drew Barrymore",
                 artist: "SZA",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b2734c79d5ec52a6d0302f3add25",
                 duration: 232,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Drew%20Barrymore.mp3"),
            
            Song(title: "505",
                 artist: "Arctic Monkeys",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b2730c8ac83035e9588e8ad34b90",
                 duration: 254,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/505.mp3"),
            
            Song(title: "Green Eyes",
                 artist: "Coldplay",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b273de09e02aa7febf30b7c02d82",
                 duration: 224,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Green%20Eyes.mp3"),
            
            Song(title: "Pain The Town Red",
                 artist: "Doja Cat",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b2737acee948ecac8380c1b6ce30",
                 duration: 232,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Doja%20Cat%20-%20Paint%20The%20Town%20Red%20(Lyrics).mp3"),
            
            Song(title: "I Saved the World Today",
                 artist: "Eurythmics",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b2731953d5f790ed223752056f8b",
                 duration: 287,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Eurythmics,%20Annie%20Lennox,%20Dave%20Stewart%20-%20I%20Saved%20the%20World%20Today%20(Official%20Video).mp3"),
            
            Song(title: "Love On Top",
                 artist: "Beyoncé",
                 imageURL: "https://i.scdn.co/image/ab67616d0000b273ff5429125128b43572dbdccd",
                 duration: 190,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Beyoncé%20-%20Love%20On%20Top%20(Official%20Video).mp3"),
            
            Song(title: "Dreams",
                 artist: "Fleetwood",
                 imageURL: "https://i.scdn.co/image/ab67616d00001e0257df7ce0eac715cf70e519a7",
                 duration: 258,
                 audioURL: "https://github.com/DanielSelas/jukebox-songs/raw/refs/heads/main/Dreams%20(2004%20Remaster).mp3")
        ]
        
        for song in songs {
            let songDict: [String: Any] = [
                "title": song.title,
                "artist": song.artist,
                "imageURL": song.imageURL,
                "duration": song.duration,
                "audioURL": song.audioURL
            ]
            dbRef.child("Library").childByAutoId().setValue(songDict) { error, _ in
                if let error = error {
                    print("❌ Error adding song: \(error.localizedDescription)")
                } else {
                    print("✅ Song '\(song.title)' added successfully!")
                }
            }
        }
    }
}
