# GlassOneNavBar Example

This is a demo project for the `glass_one_nav_bar` package. The application follows **Clean Architecture** principles and uses `go_router` for navigation and `flutter_bloc` (Cubit) for theme state management.

## 🚀 Requirements

The project is configured to use **FVM** (Flutter Version Management).

- [FVM](https://fvm.app/) installed on your system.

## 🛠️ How to Run the Project

1. **Navigate to the example folder**:
   ```bash
   cd example
   ```

2. **Install the configured Flutter version** (if not already present):
   ```bash
   fvm install
   ```

3. **Get dependencies**:
   ```bash
   fvm flutter pub get
   ```

4. **Run the application**:
   ```bash
   fvm flutter run
   ```

## 📱 Project Structure

- `lib/core`: Contains router configuration (`go_router`), Dependency Injection system (`get_it`), and theme definitions.
- `lib/presentation`: Contains Cubits for state management and UI pages/widgets.
- `lib/main.dart`: Application entry point that initializes the locator and config before running the app.

## 🎨 Demo Features

- **Glass Navigation**: A transparent navigation bar with a blurred glass effect.
- **Theme Switching**: Go to "Settings" to switch between System, Light, and Dark modes.
- **Mock Data**: Sample card lists for each section of the app.
