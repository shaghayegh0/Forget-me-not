# 🌸 Forget Me Not
### A personal vocabulary journal for iOS — built with SwiftUI

Forget Me Not is a vocabulary app for storing, browsing, and reviewing words across multiple languages. Each word gets its own colour-coded card based on its grammatical type, with English and Farsi definitions shown side by side.

<div align="center">
<img height="500" alt="IMG_0864" src="https://github.com/user-attachments/assets/295620ad-1ab6-40b4-9f93-ffbf0143aa37" />
<img height="500" alt="IMG_0857" src="https://github.com/user-attachments/assets/26d83d10-321e-40f5-a045-2ea21bcf6c14" />
<img height="500" alt="IMG_0863" src="https://github.com/user-attachments/assets/be145a8f-54f2-492c-b716-c6ba588f7d0f" />

*Main & Add Word & Edit pages*
</div>


---

## Features

- Full CRUD — add, edit, delete, and view words
- Colour-coded cards by grammatical type (noun, verb, adjective, etc.)
- Search across words, definitions, and example sentences
- Sort by A–Z, Type, Newest First, or Favourites First
- Favourite words
- Persistent local storage via UserDefaults

## Project structure

```
WordBook/
├── WordBook.xcodeproj/
│   └── project.pbxproj
└── WordBook/
    ├── WordBookApp.swift       ← App entry point
    ├── WordModel.swift         ← Data model + UserDefaults storage
    ├── ContentView.swift       ← Home screen with word list cards
    ├── WordDetailView.swift    ← Full word detail page
    ├── AddWordView.swift       ← Add new word form
    ├── EditWordView.swift      ← Edit existing word form
    └── Assets.xcassets/
        └── AppIcon.appiconset/ ← App icon in all required sizes
```

---

## Setup 

1. Download and unzip `ForgetMeNot.zip`
2. Sign in with your Apple ID
3. Check **Automatically manage signing** in Signing & Capabilities
4. Set **Team** to your Apple ID
5. Change the **Bundle Identifier** to something unique, e.g. `com.yourname.forgetmenot`
6. Plug your iPhone into your Mac via USB
7. On your iPhone go to **Settings → Privacy & Security → Developer Mode** and turn it **on** (requires a restart)
8. Back in Xcode, click the device selector at the top of the window and choose your iPhone from the list
9. Xcode build >> the app gets installed on your iPhone
10. The first time, iOS will block the app with an "Untrusted Developer" warning >> Settings >> General >> VPN & Device Management >> trust your apple ID

---

## The app icon

The icon was generated programmatically using Python and the Pillow image library. Here's what it does:

1. Creates a 1024×1024 RGBA canvas with a deep navy rounded background (`#080A1C`)
2. Draws a radial blue glow in the centre using layered semi-transparent ellipses
3. Draws five petals by creating a tall ellipse pointing upward, then rotating it around the centre at 72° intervals to form a forget-me-not flower shape
4. Adds an inner highlight stripe to each petal for depth
5. Draws a large golden yellow circle in the centre with a highlight spot and a darker rim
6. Places five small yellow dots between each petal as detail
7. Exports the 1024px master, then resizes it to all sizes required by iOS (20, 29, 40, 58, 60, 76, 80, 87, 120, 152, 167, 180px) with a `Contents.json` file so Xcode knows which size goes where

---

## Possible features to add next

- **Quiz mode** — show the word, tap to reveal the definition
- **Mastery tracking** — mark words as learning / familiar / mastered
- **Filter by type** — tap Nouns to see only nouns
- **Word of the day** — one random word highlighted on the home screen
- **Share a word** — share "lac (n.) — lake — دریاچه" as text via iOS share sheet
- **Stats page** — word count by type, words added this week
- **Daily push notifications** — remind users of saved words with a daily word notification
- **SwiftData migration** — replace UserDefaults with a proper database for more robust storage

---

*Built with SwiftUI · iOS 17+ · Xcode 15+*
