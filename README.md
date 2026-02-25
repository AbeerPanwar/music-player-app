# 🎵 Flutter Music Player App

A modern **full-stack music streaming app** built using **Flutter + FastAPI** with a clean UI, background playback, and cloud storage support.

This app allows users to discover songs, play music with a beautiful player UI, like tracks, upload songs, and enjoy background playback with notification controls.

---

## 🚀 Tech Stack

### Frontend

* Flutter
* Riverpod (State Management)
* Hive + SharedPreferences (Local Database)

### Backend

* FastAPI (Python)
* PostgreSQL (Database)
* Cloudinary (Audio + Thumbnail Storage)

### Other

* Background Audio Playback
* Media Notification Controls

---

## ✨ Features

✅ Recently Played Section
✅ Discover Songs Section
✅ Persistent Music Bottom Slab
✅ Expandable Music Player Sheet
✅ Like / Favorite Songs
✅ Library Page
✅ Upload Songs with Thumbnail
✅ Dynamic Gradient UI based on Song Color
✅ Background Playback Support
✅ Notification Panel Controls
✅ Cloud Storage Integration

---

## 📱 Screenshots

<table>
  <tr>
    <td align="center"><b>Home Page</b></td>
    <td align="center"><b>Music Player</b></td>
     <td align="center"><b>Library Page</b></td>
  </tr>
  <tr>
    <td><img src="assets/screenshots/home.jpeg" width="250"></td>
    <td><img src="assets/screenshots/player.jpeg" width="250"></td>
     <td><img src="assets/screenshots/library.jpeg" width="250"></td>
  </tr>
  
  <tr>
    <td align="center"><b>Upload Song Page</b></td>
    <td align="center"><b>Notification Panel</b></td>
  </tr>
  <tr>
    <td><img src="assets/screenshots/upload.jpeg" width="250"></td>
    <td><img src="assets/screenshots/notification.jpeg" width="250"></td>
  </tr>
</table>


---

## 🏗️ Architecture Overview

```
Flutter App
   │
   ├── Riverpod State Management
   │
   ├── Local Storage
   │     ├── Hive
   │     └── SharedPreferences
   │
   └── FastAPI Backend
          │
          ├── PostgreSQL Database
          └── Cloudinary Storage
```

---

## ⚙️ Installation

### 1️⃣ Clone Repository

```bash
git clone https://github.com/yourusername/music-player.git
cd music-player
```

### 2️⃣ Flutter Setup

```bash
flutter pub get
flutter run
```

### 3️⃣ Backend Setup (FastAPI)

```bash
cd server
pip install -r requirements.txt
uvicorn main:app --reload
```

---

## 🔐 Environment Variables

Create `.env` file in backend:

```
DATABASE_URL=your_postgresql_url
CLOUDINARY_URL=your_cloudinary_url
SECRET_KEY=your_secret
```

---

## 📂 Folder Structure

```
lib/
 ├── core/
 ├── features/
 │    ├── home/
 |         |──view/
 |         |──viewModel/
 |         |──Model/
 │    ├── auth/
 |         |──view/
 |         |──viewModel/
 |         |──Model/
 └── main.dart
```

---

## 🎯 Future Improvements

* Playlist Support
* Search Functionality
* Offline Download
* User Authentication UI Improvements
* Equalizer Integration

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first.

---


## 👨‍💻 Author

**Abeer Panwar**

---

⭐ If you like this project, consider giving it a star!
