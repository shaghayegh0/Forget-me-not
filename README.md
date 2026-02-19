# 🌸 Forget Me Not
### A personal vocabulary journal for iOS — built with SwiftUI

Forget Me Not is a vocabulary app for storing, browsing, and reviewing words across multiple languages. Each word gets its own colour-coded card based on its grammatical type, with English and Farsi definitions shown side by side.

---

## Features

- **Add words** with word type, gender, English definition, Farsi definition, and an example sentence
- **Colour-coded cards** — each grammatical type (noun, verb, adjective, etc.) has its own distinct pastel colour so you can scan the list at a glance
- **Gender badges** — masculine, feminine, and neuter labels with colour indicators
- **Edit any word** — tap a word to open its detail view, then tap Edit in the top right
- **Delete words** — trash icon on each card with a confirmation alert
- **Persistent storage** — words are saved locally using UserDefaults and survive app restarts
- **Custom app icon** — a hand-generated forget-me-not flower with periwinkle blue petals and a golden centre on a deep navy background

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

- **Search bar** — filter words as you type
- **Quiz mode** — show the word, tap to reveal the definition
- **Mastery tracking** — mark words as learning / familiar / mastered
- **Filter by type** — tap Nouns to see only nouns
- **Sort options** — alphabetical, newest first, by type
- **Word of the day** — one random word highlighted on the home screen
- **Share a word** — share "lac (n.) — lake — دریاچه" as text via iOS share sheet
- **Stats page** — word count by type, words added this week

---

*Built with SwiftUI · iOS 17+ · Xcode 15+*
