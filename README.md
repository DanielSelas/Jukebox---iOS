🎶 Jukebox

Jukebox is a music-focused iOS app developed as a final project for an iOS development course. It demonstrates practical integration of Firebase Realtime Database, combined with elegant UI using UIKit and Storyboards. The app allows users to browse songs stored in Firebase, organize them into playlists, and play music in a clean and intuitive interface.


🚀 Purpose

This app was built as a final project assignment requiring the use of Firebase. Jukebox simulates a personal music library experience, where all songs and playlists are stored in Firebase and accessed via a user-friendly mobile interface.


👥 Target Audience

The app is suitable for anyone who enjoys music and wants a simple, smooth experience browsing and playing songs stored in the cloud.


☁️ Store Model

There is no user sharing or accounts. All songs and playlists are stored in the cloud (Firebase), but the app presents them as “my music”. This includes:
	•	All songs I saved to Firebase
	•	My personal playlists created in Firebase


 ✨ Features

🔐 Login Screen
	•	Lets the user enter a room name (used internally).



 🏠 Main Interface (Tab Bar)
 
	•	Library Tab – Browse all songs from Firebase.
	•	Playlist Tab – View custom playlists with songs.
	•	Now Playing Tab – See and control the currently playing track.


📚 Song Library

	Alphabetically or shuffled sorted list of songs from Firebase.
	Each song displays:
	•	Artwork
	•	Title
	•	Artist
	•	Duration


🎼 Playlist

	Each playlist has a name and cover image (from a URL).
	Songs are distributed across playlists.
	Users can:
	•	Play a playlist directly
	•	Expand to view the full song list in a bottom sheet


▶️ Now Playing
	Full-screen playback view:
	•	Album artwork in the center, which get bigger when song is playing and smaller when song is paused
	•	Animated scrolling song + artist name
	•	Dynamic background color from artwork
	•	Playback controls: Play, Pause, Next


🧰 Technologies Used
	•	Language - Swift (UIKit)
	•	Database - Firebase Realtime Database
	•	UI - Storyboards, AutoLayout, TableViews
	•	Image Handling - Remote image loading with Data()
  •	Audio Playback - AVFoundation
	•	Architecture - MVC-style with dedicated view controllers

 🏗️ Project Structure
 
 	•	LoginViewController: Handles user login (basic version)
	•	LibraryViewController: Displays all songs saved in Firebase
	•	PlaylistViewController: Shows playlists and allows interaction
	•	NowPlayingViewController: Plays the selected song or playlist
	•	PlaylistDetailViewController: Opens a bottom sheet with the playlist’s songs
 
  Custom Cells : 
	  •	LibrarySongCell: Song display with “Add to Playlist” button
	  •	PlaylistCell: Playlist preview with cover, name, song count, and two buttons (Play, Expand)
 
