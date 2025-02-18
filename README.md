# MyVault

## Overview
MyVault is a Flutter-based financial tracking application that allows users to manage their savings, track deposits and withdrawals, and maintain a historical trail of transactions. The app uses **Flutter Riverpod** for state management and **Hive** for local data persistence.

## Project Structure

```
lib/
│-- core/                  # Contains core utilities and constants
│-- data/                  # Data layer for local storage and repository pattern
│-- presentation/          # UI and State Management
│   │-- providers/         # Riverpod providers for state management
│   │-- views/             # UI Screens for the application
│-- main.dart              # Application entry point
│-- app_routes.dart        # Centralized app navigation handling
│-- constants.dart         # Stores constant values such as Hive keys
```

### 1. **Core**
- Contains global utilities and app-wide constants.

### 2. **Data**
- Manages data persistence using Hive.
- Contains repositories responsible for CRUD operations.

### 3. **Presentation**
- **Views:** Houses all the UI screens, including `HomeScreen`, `SavingsEntryScreen`, and `SavingsHistoryScreen`.
- **Providers:** Implements state management using Riverpod.

"Riverpod + Hive Clean Architecture" 🚀

✅ Clean Architecture-inspired (separates UI, domain, and data).

✅ Riverpod for state management (decoupled from UI).

✅ Hive as local storage (with data modeling and conversion).

## State Management Choice: **Riverpod**

We use **Flutter Riverpod** for its simplicity, scalability, and reusability in managing application state. Key benefits:
- **Performance:** Avoids unnecessary widget rebuilds.
- **Scoped State Management:** Easily manages app-wide and screen-specific states.
- **Predictability:** Immutable state updates for better debugging and consistency.

## Data Persistence: **Hive**

To persist user savings history and transactions across app restarts, we use **Hive**:
- **Fast and Lightweight** compared to SQLite.
- **Key-Value Storage** for easy data retrieval.
- **No Native Dependencies**, making it efficient for mobile apps.

## Navigation

Navigation is handled using `onGenerateRoute` in `app_routes.dart`. Routes are defined as:
```dart
class AppRoutes {
  static const String main = '/';
  static const String savingsEntry = '/savings_entry';
  static const String savingsHistory = '/savings_history';
}
```

## Features
- 💰 **Add Savings**: Users can enter amounts to be saved.
- 🔄 **Withdraw Funds**: Allows withdrawals with tracking.
- 📊 **Savings History**: Displays a historical record of savings and withdrawals.
- 🔄 **Data Persistence**: Ensures transaction history remains intact even after app restarts.

## Getting Started
1. Install Flutter and dependencies:
   ```sh
   flutter pub get
   ```
2. Run the application:
   ```sh
   flutter run
   ```
3. If using Hive, ensure storage permissions are granted.

## Contributions
Contributions are welcome! Please submit pull requests with detailed explanations.

