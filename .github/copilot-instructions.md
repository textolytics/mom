## Purpose

This file gives concise, project-specific guidance for AI coding agents working in this Flutter app (rooted at the repository root). Focus on being immediately productive: build/run/test commands, where to change platform code, and project conventions to follow.

## Big picture

- **App type:** Flutter multi-platform app with targets: Android, iOS, macOS, Linux, Windows, Web.
- **Entry point:** [lib/main.dart](lib/main.dart) — start here for app behavior and widget tree.
- **Platform glue:** native runners live under platform folders: [android/](android/), [ios/Runner/](ios/Runner/), [macos/Runner/](macos/Runner/). Avoid modifying generated plugin registrants in those folders.

## Build / run / debug (essential commands)

- Install deps: `flutter pub get` run from repository root (references [pubspec.yaml](pubspec.yaml)).
- Run locally: `flutter run` (add `-d <device>` for specific targets). For web: `flutter run -d chrome`.
- Build artifacts: `flutter build apk`, `flutter build ios`, `flutter build macos`, `flutter build web` as needed.
- Android native builds can use the wrapper: run `./android/gradlew assembleDebug` inside [android/](android/).
- Tests: `flutter test` from repo root. Linting: `flutter analyze` (project uses flutter_lints via [pubspec.yaml](pubspec.yaml)).

## Project-specific conventions & patterns

- Keep UI and app logic in [lib/]. Small, self-contained widgets preferred; look for the root MaterialApp/CupertinoApp in [lib/main.dart](lib/main.dart).
- Do not edit platform-generated files: search for files named GeneratedPluginRegistrant or files inside platform ephemeral/generated folders.
- Native platform changes belong in the platform folder matching the target (e.g., iOS native code in [ios/Runner/], Android Gradle/Kotlin in [android/]).
- Gradle scripts use Kotlin DSL (files with .kts). When modifying Android build logic prefer editing the top-level [android/build.gradle.kts](android/build.gradle.kts) and module scripts under [android/app/].

## Integration points & external deps

- Dependencies are declared in [pubspec.yaml](pubspec.yaml). This repo currently has no third-party packages beyond Flutter SDK; add packages here and run `flutter pub get`.
- Platform plugins will generate native registrant files under each platform folder. When adding plugins, verify generated native code and run platform-specific builds.

## Where to look for examples in the repo

- App entry and widget tree: [lib/main.dart](lib/main.dart)
- Flutter iOS runner and native config: [ios/Runner/Info.plist](ios/Runner/Info.plist)
- Android Gradle/Kotlin scripts: [android/build.gradle.kts](android/build.gradle.kts) and [android/app/](android/app/)
- macOS runner: [macos/Runner/AppDelegate.swift](macos/Runner/AppDelegate.swift)

## Behavior expectations for AI changes

- Make minimal, focused edits and run `flutter analyze` and `flutter test` where applicable.
- Prefer edits in [lib/] for UI/logic. For cross-cutting or platform work, explain the change and link affected platform files.
- When adding dependencies, update [pubspec.yaml](pubspec.yaml) and provide exact `flutter pub get` and build steps.

## When to ask for human review

- Any change to native code under [ios/], [android/], [macos/], [windows/], [linux/] that affects signing, native APIs, or CI should request a human review.
- Changes to build scripts (Gradle .kts files) require a review before merging.

---

If any section is unclear or you'd like more examples (tests, CI, or common refactors), tell me which area to expand.
