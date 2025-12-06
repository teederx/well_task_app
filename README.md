# WellTask - Advanced Productivity App

WellTask is a feature-rich Flutter application designed to help users organize tasks, track time, and improve productivity with AI-powered insights.

## 🚀 Features

### ✅ Core Task Management
-   **Create, Read, Update, Delete (CRUD)** tasks.
-   **Categorization**: Organize by Work, Personal, Health, Study, etc.
-   **Prioritization**: Low, Medium, High priority levels with visual indicators.
-   **Tags**: Add custom tags for flexible filtering.
-   **Subtasks**: Break down complex tasks into manageable steps.
-   **Recurring Tasks**: Set tasks to repeat daily, weekly, or monthly.

### ⏱️ Productivity Tools
-   **Time Tracking**: Built-in timer to log time spent on specific tasks.
-   **Statistics Dashboard**: Visualize completion rates, focus time, and weekly activity.
-   **Calendar View**: Drag-and-drop tasks (coming soon) and view deadlines by month/week.

### 🤖 AI-Powered Insights
-   **Gemini Integration**: Uses Google Gemini AI to analyze your task list.
-   **Productivity Score**: Get a calculated score based on your completion history and priority handling.
-   **Smart Recommendations**: tailored advice to improve your workflow.

### 📎 Media & Attachments
-   **File Support**: Attach images and documents to tasks.
-   **Offline Persistence**: Attachments are stored locally for quick access.

### 🔔 Notifications & Offline Support
-   **Smart Reminders**: Schedule alarms and get "5-minute before" warnings.
-   **Offline Mode**: Full functionality without internet; syncs automatically when online.
-   **Connectivity Indicator**: Visual feedback when network is lost.

### 🎨 UI/UX
-   **Modern Design**: Clean aesthetics with `flutter_screenutil` for responsiveness.
-   **Haptic Feedback**: Tactile response for interactions.
-   **Animations**: Smooth transitions using `flutter_animate` and custom implementations.

## 🛠️ Tech Stack

-   **Framework**: Flutter
-   **Language**: Dart
-   **State Management**: Riverpod (Code Generation)
-   **Local Database**: Hive
-   **Backend/Auth**: Firebase (Auth, Firestore)
-   **AI**: Google Generative AI SDK
-   **Navigation**: GoRouter
-   **Architecture**: Clean Architecture (Data, Domain, Presentation layers)

## 📦 Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/well_task_app.git
    cd well_task_app
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Setup Environment:**
    -   Create a `.env` file in the root.
    -   Add your Gemini API Key:
        ```env
        GEMINI_API_KEY=your_api_key_here
        ```

4.  **Run Code Generation:**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

5.  **Run the App:**
    ```bash
    flutter run
    ```

## 🧪 Testing

The project includes a suite of tests:

-   **Unit Tests**: `flutter test test/models`
-   **Widget Tests**: `flutter test test/widgets`
-   **Provider Tests**: `flutter test test/providers`
-   **Integration Tests**: `flutter test integration_test/app_test.dart`

## 📂 Project Structure

```
lib/
├── data/
│   ├── models/       # Data models (Freezed)
│   ├── services/     # API clients, Local Storage, Notification Service
│   └── repositories/ # Data access abstraction
├── presentation/
│   ├── providers/    # Riverpod providers
│   ├── screens/      # UI Screens (TaskPage, InsightsPage, etc.)
│   └── widgets/      # Reusable UI components
├── utils/
│   ├── config/       # Router, Theme, Date Formatting
│   └── constants/    # Colors, Strings
└── main.dart         # App Entry Point
```

## 🤝 Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## 📄 License

This project is licensed under the MIT License.
