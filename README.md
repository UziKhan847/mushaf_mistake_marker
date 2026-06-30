# Mushaf Mistake Marker

A cross-platform Flutter app for tracking mistakes in **Hifz** (Qur'an memorization) and **Tajwid**. Read the Mushaf, mark where you slip, and watch your progress page by page, surah by surah, and juz by juz.

> **Status:** v2.0.1 · Built with Flutter & Dart

---

## Overview

Mushaf Mistake Marker turns your daily revision into measurable feedback. As you recite, you highlight the exact words where mistakes happen and tag each one by type. The app keeps a running tally of those marks across every division of the Qur'an, so you always know which pages need the most attention.

## Features

### Mark mistakes by category
Each marked word is colour-coded by the kind of error:

| Category      | Color  | Meaning                                   |
| ------------- | ------ | ----------------------------------------- |
| Mistake       | Red    | A new error during recitation             |
| Old Mistake   | Blue   | A recurring error from a previous session |
| Doubt         | Purple | A spot you were unsure about              |
| Tajwid        | Green  | A rule-of-recitation (tajwid) error       |

### Reading & annotation tools
- **Highlighter** for marking words, with an **eraser** to clear them.
- **Annotate mode** for adding notes to the page.
- **Audio mode** for playing back recitation while you follow along.
- **Undo** to step back through recent actions.
- **Single-page and dual-page** layouts, with automatic portrait/landscape handling.
- **Left- or right-hand** navigation bar placement.

### Navigation & index
Jump anywhere in the Mushaf and review your stats per division:
- Pages · Surahs · Juz · Hizb · Rubʿ · Manzil · Sajdah
- Built-in **search** and an **index** sheet for fast navigation.

### Progress tracking
Per-section statistics tally your mistakes, old mistakes, doubts, tajwid errors, and revisions — so you can spot the pages that need the most work.

### Multiple users
Track separate progress for more than one person (e.g. a teacher with several students), each with their own marks and settings.

### Personalization
- **Six color themes:** Gold, Blue, Red, Green, Purple, and Monochrome.
- **Light and dark mode**, persisted between sessions.

## Tech Stack

- **Framework:** [Flutter](https://flutter.dev) (Dart SDK `>=3.10.0 <4.0.0`)
- **State management:** [Riverpod](https://riverpod.dev) (`flutter_riverpod`)
- **Local database:** [ObjectBox](https://objectbox.io)
- **Preferences:** `shared_preferences`
- **Audio:** `just_audio` (with `just_audio_media_kit` for desktop)
- **Rendering:** `flutter_svg` and WebP sprite sheets for Mushaf pages
- **Typography:** Scheherazade New (Arabic) + a custom icon font

## Supported Platforms

Android · iOS · Linux · macOS · Windows · Web

## Getting Started

### Prerequisites
- The [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and on your `PATH`.
- A device or emulator for your target platform.

### Setup

```bash
# Clone the repository
git clone https://github.com/UziKhan847/mushaf_mistake_marker.git
cd mushaf_mistake_marker

# Fetch dependencies
flutter pub get

# Generate code (ObjectBox models, JSON serializers)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Building a release

```bash
flutter build apk        # Android
flutter build ios        # iOS
flutter build linux      # Linux
flutter build macos      # macOS
flutter build windows    # Windows
flutter build web        # Web
```

## Project Structure

```
lib/
├── main.dart                 # App entry point, theme & storage setup
├── constants.dart            # Colors and shared constants
├── enums.dart                # HighlightType, AnnotationMode, AppTheme, IndexTab, …
├── custom_nav_bar/           # Bottom/side toolbar and its items
├── mushaf/                   # Page rendering, annotator, painters, headers
├── image/                    # Image-based Mushaf rendering
├── page_data/                # Page metadata
├── models/                   # Stats and surah models
├── objectbox/                # Database entities & store (User, Settings, …)
├── providers/                # Riverpod providers (state, sprites, db boxes)
├── sprite_models/            # Sprite sheet data models
├── pages/                    # Homepage, loading screen
├── widgets/                  # Reusable UI (index, sheets, overlays, buttons)
├── overlay/                  # Overlay/popup UI types
└── my_themes.dart            # Light/dark theme definitions
```

## License

No license has been specified for this project. Unless a license file is added, all rights are reserved by the author.

## Author

Built by [UziKhan847](https://github.com/UziKhan847).