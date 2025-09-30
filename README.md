# theme_setup

A production-ready Flutter project demonstrating robust, flexible, and maintainable theming with Material 3, Hive persistence, go_router deep-linking, and flutter_riverpod state management.

---

## Features

- **Material 3 theming**: Dynamic seed color, light/dark/system modes, runtime customization
- **Theme settings persisted** to Hive (local storage)
- **Riverpod** for state management (all business logic outside UI)
- **go_router** for navigation, deep-linking, and web-friendly routing
- **Demo screens**: Home, Settings, Product Details (deep-linkable)
- **Extensible, maintainable folder structure**
- **Basic unit test** for theme persistence
- **Recommended lints** and analysis options

---

## Getting Started

### 1. Install dependencies

```sh
flutter pub get
```

### 2. Run the app

- Android/iOS:
  ```sh
  flutter run
  ```
- Web:
  ```sh
  flutter run -d chrome
  ```

### 3. Run tests

```sh
flutter test
```

---

## Project Structure

```
lib/
  main.dart
  src/
    app.dart
    app_router.dart
    features/
      home/
        home_screen.dart
      settings/
        settings_screen.dart
      product/
        product_screen.dart
    services/
      storage_service.dart
    theme/
      theme_controller.dart
      theme_defs.dart
      theme_models.dart
    widgets/
      adaptive_scaffold.dart
      color_picker_button.dart
```

---

## Theming & Persistence

- All theme settings (mode, seed color) are managed by Riverpod and persisted to Hive.
- Change theme mode or color in the app, restart, and your settings are restored.
- See `theme_controller.dart` and `theme_models.dart` for logic and model.

---

## Routing & Deep Linking

- Uses `go_router` for all navigation and deep-linking.
- Example deep links:
  - `/product/42` (web path or app route)
  - `myapp://product/42` (mobile deep link)
- See `app_router.dart` for route config.

### Deep Link Setup

#### Android

Edit `android/app/src/main/AndroidManifest.xml`:

```xml
<activity ...>
  ...
  <intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="myapp" android:host="product" />
    <data android:scheme="https" android:host="yourdomain.com" />
  </intent-filter>
</activity>
```

#### iOS

Edit `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>myapp</string>
    </array>
  </dict>
</array>
```

#### Web

- Uses path-based routing by default.
- Configure your web server to rewrite all routes to `index.html` for client-side routing.

---

## How to Extend

### Add new theme options

- Add fields to `ThemeSettings` in `theme_models.dart`.
- Update `ThemeController` to persist/load new fields.
- Add UI controls in Settings/Home screens.

### Add new routes/deep links

- Add a new `GoRoute` in `app_router.dart`.
- Create a new screen in `features/`.
- Update deep link intent filters as needed.

---

## Acceptance Criteria Checklist

- [x] App starts and loads persisted theme settings from Hive without crash.
- [x] The app allows switching between System/Light/Dark modes and persists selection.
- [x] The app allows choosing a seed color and the UI updates instantly (and persists).
- [x] go_router routes work and deep links `/product/42` and `myapp://product/42` open the product screen with id `42`.
- [x] Code uses Riverpod for theme state and does not put business logic in UI widgets.
- [x] Basic unit test(s) for storage read/write of theme settings pass.
- [x] README contains step-by-step setup, including Hive initialization, Android/iOS deep link setup, and how to extend the theme.

---

## QA Steps

- Change theme mode and seed color, restart app, verify persistence.
- Open `/product/42` via deep link or browser, verify correct screen.
- Run `flutter test` and verify all tests pass.

---

## Notes

- For advanced color picking needs, customize `ColorPickerButton` or swap in a different picker package.
- For localization, add ARB files and use `intl`/`flutter_localizations`.
- For production, consider splash screen, i18n, and theme migration helpers.
- License: MIT 2025 kidpech-code
