# WellTask - Advanced Productivity Ecosystem

WellTask is a high-performance, feature-rich productivity suite built with Flutter. It combines a beautiful, responsive user interface with a robust, reactive architecture designed for maximum reliability and snappy performance.

## ✨ Premium Features

### ✅ Professional Task Management
-   **Optimistic UI Engine**: Experience zero-latency. Deleting tasks, toggling completion, and updating alarms reflect instantly in the UI, even while background synchronization is in progress.
-   **Granular Subtasks**: Break complex workflows into manageable checklists with progress tracking and instant cloud-sync.
-   **Smart Recurring Engine**: Flexible scheduling for daily, weekly, or monthly tasks.
-   **High-Fidelity Metadata**: Categorize with smart tags, priorities (Low, Medium, High), and thematic categories (Work, Personal, Health, Study, etc.).

### ⏱️ Productivity & Analytics
-   **Focus Time Tracking**: Integrated Pomodoro-style timer to log precision focus sessions per task.
-   **Insights Dashboard**: Dynamic visualization of your focus time, completion velocity, and weekly trends.
-   **AI Productivity Score**: Powered by Google Gemini, get a personalized efficiency rating based on your historical patterns and priority handling.

### 🤖 AI-Powered Intelligence
-   **Gemini Integration**: Large language model analysis of your productivity habits.
-   **Smart Coaching**: tailored advice and workflow optimizations delivered directly to your insights feed.

### 🔔 Reliable Notifications & Offline Resilience
-   **Killed-State Alarms**: Engineered to trigger reliably even if the app is closed or the device is rebooted.
-   **Multi-Stage Reminders**: Standard due-date alarms plus a configurable "5-minute warning".
-   **Offline-First Persistence**: Powered by Hive for instantaneous local reads. All changes are queued and automatically synced to Firebase Firestore when connectivity is restored.
-   **Auth-Synced Architecture**: A fully reactive provider chain ensures that data loads sync perfectly with your login state, eliminating "no user" race conditions.

## 🛠️ Advanced Tech Stack

-   **Frontend**: Flutter (3.x) with `flutter_screenutil` for pixel-perfect responsiveness.
-   **State Management**: **Riverpod** using code-generation for a strictly typed, reactive dependency tree.
-   **Local Storage**: **Hive** for high-speed NoSQL persistence.
-   **Backend**: **Firebase** (Authentication & Cloud Firestore).
-   **Architecture**: **Clean Architecture** (Separated Domain, Data, and Presentation layers) to ensure testability and scalability.
-   **Navigation**: **GoRouter** for declarative, deep-linkable routing.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- A Firebase project with Auth and Firestore enabled
- Google Gemini API Key

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/well_task_app.git
    cd well_task_app
    ```

2.  **Environment Setup:**
    Create a `.env` file in the root directory and add:
    ```env
    GEMINI_API_KEY=your_gemini_api_key_here
    ```

3.  **Dependency Installation & Code Gen:**
    ```bash
    flutter pub get
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Firebase Configuration:**
    Ensure your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are correctly placed, or use `flutterfire configure`.

5.  **Run the App:**
    ```bash
    flutter run
    ```

## 📂 Architecture Overview

```text
lib/
├── core/
│   ├── usecase/         # Usecase base classes
│   ├── errors/          # Custom failures and exceptions
│   └── utils/           # Shared configurations (Router, Haptics, Themes)
├── data/
│   ├── models/          # Data models with Freezed/JsonSerializable
│   ├── data_sources/    # Firebase configurations
│   └── repositories/    # API and Local DB implementations
├── domain/
│   ├── entities/        # Pure business objects
│   └── repositories/    # Abstract interfaces
│   └── usecases/        # Business logic units
├── presentation/
│   ├── providers/       # Reactive state providers
│   ├── screens/         # Feature-specific UI screens
│   └── widgets/         # Atomic UI components
└── main.dart            # Multi-zoned app entry
```

## 🤝 Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
