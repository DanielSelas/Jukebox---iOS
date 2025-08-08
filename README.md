# 🎶 Jukebox

Jukebox is a music-focused iOS app developed as a final project for an iOS development course. It demonstrates practical integration of Firebase Realtime Database, combined with elegant UI using UIKit and Storyboards. The app allows users to browse songs stored in Firebase, organize them into playlists, and play music in a clean and intuitive interface.

---
## 🎥 Demo
<div align="center">
  <video src="https://github.com/user-attachments/assets/a056b9fc-a847-42ad-b564-1b6e0ff79c15" controls width="300"></video>
</div>

---
## 🚀 Purpose  
This app was built as a final project assignment requiring the use of Firebase. Jukebox simulates a personal music library experience, where all songs and playlists are stored in Firebase and accessed via a user-friendly mobile interface.

---

## 👥 Target Audience  
The app is suitable for anyone who enjoys music and wants a simple, smooth experience browsing and playing songs stored in the cloud.

---

## ☁️ Store Model  
There is no user sharing or accounts. All songs and playlists are stored in the cloud (Firebase), but the app presents them as “my music”. This includes:
- All songs I saved to Firebase  
- My personal playlists created in Firebase

---

## ✨ Features

### 🔐 Login Screen  
Lets the user enter a room name (used internally).

<p align="center">
  <img src="https://github.com/user-attachments/assets/9af9bd3f-8cbc-4428-a32a-9be1ec6d75c9" width="45%" />
  <img src="https://github.com/user-attachments/assets/9c178074-9c81-47cb-a0b8-455a01c69307" width="45%" />
</p>

---

### 🏠 Main Interface (Tab Bar)  
- **Library Tab** – Browse all songs from Firebase  
- **Playlist Tab** – View custom playlists with songs  
- **Now Playing Tab** – See and control the currently playing track  

<p align="center">
  <img src="https://github.com/user-attachments/assets/e56df346-bd93-4b0f-b6f0-0993e64cb6e6" width="45%" />
</p>

---

### 📚 Song Library  
Alphabetically or shuffled sorted list of songs from Firebase.  
Each song displays:
- Artwork  
- Title  
- Artist  
- Duration  

<p align="center">
  <img src="https://github.com/user-attachments/assets/f1ad90fb-3348-47bd-bb48-f1a606137a7f" width="45%" />
  <img src="https://github.com/user-attachments/assets/1551e617-7cd2-4add-bff0-4914cb42fc19" width="45%" />
</p>

---

### 🎼 Playlist  
Each playlist has a name and cover image (from a URL).  
Songs are distributed across playlists.  
Users can:
- Play a playlist directly  
- Expand to view the full song list in a bottom sheet  

<p align="center">
  <img src="https://github.com/user-attachments/assets/e6472710-0d68-472c-978c-15e269f49efd" width="30%" />
  <img src="https://github.com/user-attachments/assets/308aa814-372d-45bd-8e31-e19a5be35d90" width="30%" />
  <img src="https://github.com/user-attachments/assets/3e00280a-2dfc-4a78-9c17-2f214ac41ea3" width="30%" />
</p>

---

### ▶️ Now Playing  
Full-screen playback view:
- Album artwork in the center (grows/shrinks based on playback)  
- Animated scrolling song + artist name  
- Dynamic background color from artwork  
- Playback controls: Play, Pause, Next  

<p align="center">
  <img src="https://github.com/user-attachments/assets/4ab509fa-1a57-48de-bbd4-31d6646c2d4c" width="30%" />
  <img src="https://github.com/user-attachments/assets/5c6cf141-0099-48b3-9a98-52fa0bb8b44c" width="30%" />
  <img src="https://github.com/user-attachments/assets/d0103087-526e-431f-a97a-1caf171764aa" width="30%" />
</p>

---

## 🧰 Technologies Used
- Language: Swift (UIKit)  
- Database: Firebase Realtime Database  
- UI: Storyboards, AutoLayout, TableViews  
- Image Handling: Remote image loading with `Data()`  
- Audio Playback: AVFoundation  
- Architecture: MVC-style with dedicated view controllers

---

## 🏗️ Project Structure
- `LoginViewController`: Handles user login (basic version)  
- `LibraryViewController`: Displays all songs saved in Firebase  
- `PlaylistViewController`: Shows playlists and allows interaction  
- `NowPlayingViewController`: Plays the selected song or playlist  
- `PlaylistDetailViewController`: Opens a bottom sheet with the playlist’s songs  

**Custom Cells**:  
- `LibrarySongCell`: Song display with “Add to Playlist” button  
- `PlaylistCell`: Playlist preview with cover, name, song count, and two buttons (Play, Expand)
