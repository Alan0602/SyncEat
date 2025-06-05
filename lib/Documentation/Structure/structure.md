# 📦 Project Structure – Flutter Diet App (with Firebase & BLoC)

This project follows a clean, modular structure using **Firebase** for backend and **BLoC** for state management.

---

## 🗂️ Folder Tree

lib/
├── core/
│ ├── constants/ # App-wide constants (e.g., colors, keys)
│ ├── utils/ # Helper functions used across app
│ └── theme/ # Light/dark theme, text styles
│
├── config/
│ ├── firebase_options.dart # Firebase setup (auto-generated)
│ └── app_router.dart # Centralized route manager
│
├── data/
│ ├── models/ # Data models for Firebase and UI
│ ├── datasources/
│ │ ├── remote/ # Firebase Firestore/Auth logic
│ │ └── local/ # Local storage (Hive, SharedPrefs)
│ └── repositories/ # Repository implementations (using Firebase)
│
├── domain/
│ ├── entities/ # Business entities (logic-only models)
│ ├── repositories/ # Abstract repository interfaces
│ └── usecases/ # Business logic (e.g., TrackMeal, Login)
│
├── presentation/
│ ├── blocs/
│ │ ├── auth/ # Auth bloc/cubit + states/events
│ │ └── diet_plan/ # Diet feature bloc/cubit
│ ├── screens/
│ │ ├── auth/ # Login, Signup, Forgot password
│ │ ├── home/ # Dashboard/homepage
│ │ └── meal_tracker/ # UI for tracking meals
│ ├── widgets/ # Reusable UI components
│ └── dialogs/ # Custom alerts/bottom sheets
│
├── routes/ # Route names and route generator
│
└── main.dart # App entry point (Firebase init + BLoC observer)


---

## ✅ Folder Explanations

- **core/** – Shared constants, helpers, and theming across the app.
- **config/** – Firebase options and routing logic.
- **data/** – Concrete data layer: Firebase logic, models, repositories.
- **domain/** – Pure business logic: reusable and testable code.
- **presentation/** – UI, screens, blocs/cubits, widgets, dialogs.
- **routes/** – Centralized route names and generator.
- **main.dart** – Initializes Firebase, sets up themes, routing, and Bloc observers.

---

## 🛠️ Technologies Used
- 🧠 **BLoC** (for scalable state management)
- 🔥 **Firebase** (Auth, Firestore, etc.)
- 🖼️ **Feature-first structure** (scalable and testable)

---

