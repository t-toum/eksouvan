# eksouvan

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# eksouvan

- ### Generate comman
    1. Generate dependencies file, model, third party.
    ```bash
        flutter pub run build_runner build
    ``` 
  if there are some conflict files you can solve by this command:

    ```bash
        flutter pub run build_runner build --delete-conflicting-outputs
    ``` 
    ```bash
        flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart
    ``` 
    1. Generate AppIcon.
    ```bash
        flutter pub get
        flutter pub run flutter_launcher_icons:main
    ``` 
