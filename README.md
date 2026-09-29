# ⚡ J.A.R.V.I.S. — Personal AI Assistant (Android Studio)

> **Just A Rather Very Intelligent System**  
> Built with Flutter & Dart for Android Studio, featuring a futuristic holographic Arc Reactor interface, agentic reasoning pipeline, live system telemetry, and voice-ready architecture.

---

## 🚀 Phase 1 Overview

Phase 1 establishes the complete foundation, modular architecture, and futuristic HUD interface in Android Studio:

- **Futuristic Animated Arc Reactor Orb (`JarvisOrb`)**: Concentric rotating rings with breathing core glow, pulsating to match system state (`READY`, `LISTENING`, `THINKING`, `SPEAKING`). Tap to interactively cycle states.
- **HUD Navigation**: 4 core modules:
  - 🖥️ **HUD Dashboard**: Real-time clock, status indicator, animated orb, live telemetry bar (CPU, RAM, Battery, Ping), quick directive input, and quick protocol shortcuts.
  - 💬 **Neural Chat Stream**: Full AI conversation stream with tool execution tags (`[TOOL: get_system_information()]`, `[TOOL: activate_study_module()]`), timestamps, and clean user/AI message bubbles.
  - 📋 **Task Scheduler**: High/Medium/Low priority task manager with completion checkboxes and custom task creator.
  - ⚙️ **System Configuration**: AI Provider selector (Gemini / GPT-4o / Local), API Key vault, voice output toggles, and security permission switches.
- **Agent Brain Controller (`JarvisBrainService`)**: State-driven reasoning loop simulating intent extraction, tool execution, and contextual response dispatch.

---

## 📂 Project Architecture

```
lib/
├── core/
│   ├── constants/
│   │   ├── jarvis_colors.dart       # Neon Cyan, Cobalt, Electric Blue palette
│   │   └── jarvis_strings.dart      # System constants & labels
│   ├── models/
│   │   ├── jarvis_state.dart        # READY, LISTENING, THINKING, SPEAKING states
│   │   ├── chat_message.dart        # Chat model with tool execution tags
│   │   └── system_metrics.dart      # CPU, RAM, battery, ping telemetry
│   └── theme/
│       └── jarvis_theme.dart        # Futuristic Dark sci-fi theme & Google Fonts
│
├── widgets/
│   ├── jarvis_orb.dart              # Custom-painted animated Arc Reactor Orb
│   ├── status_badge.dart            # Pulsing LED indicator badge
│   ├── system_telemetry_bar.dart    # Live CPU / RAM / Power / Ping HUD
│   ├── quick_actions_grid.dart      # Direct protocol shortcut grid
│   └── futuristic_card.dart         # Glassmorphic card container
│
├── screens/
│   ├── main_navigation_screen.dart  # Glassmorphic bottom navigation controller
│   ├── dashboard_tab.dart           # Primary HUD dashboard
│   ├── chat_tab.dart                # Neural chat stream & command input
│   ├── tasks_tab.dart               # Task manager & reminder scheduler
│   └── settings_tab.dart            # AI Engine & security permissions config
│
├── services/
│   ├── jarvis_brain_service.dart    # Central state & tool execution manager
│   └── telemetry_service.dart       # Real-time telemetry metric stream
│
└── main.dart                        # Application bootstrap & Android system UI overlay
```

---

## 📱 How to Run in Android Studio

### Method 1: Android Studio GUI (Easiest)
1. Open **Android Studio**.
2. Open the project folder: `C:\Users\akuma\StudioProjects\Jarve_j`.
3. In the top device dropdown bar, select your **Android Device** or **Android Emulator** (or **Chrome (web)** / **Windows (desktop)**).
4. Click the green **Run (▶)** button or press `Shift + F10`.
5. Enjoy the futuristic JARVIS interface!

### Method 2: Command Line / Terminal
Open Terminal inside Android Studio (or PowerShell in the project directory) and run:

```bash
# Run on Android Emulator or connected Phone
flutter run

# Or run instantly in Chrome browser
flutter run -d chrome

# Or run as a Windows Desktop application
flutter run -d windows
```

---

## 🧭 Next Phases
* **Phase 2:** Connect Live Gemini / OpenAI API for real-time natural language answers
* **Phase 3:** Integrate Speech-To-Text (STT) & Text-To-Speech (TTS) for voice assistant mode
* **Phase 4:** Computer / Device tools (Open apps, launch web search, control device)
* **Phase 5:** Persistent SQLite memory vault for long-term user recall
