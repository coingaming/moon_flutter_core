# Repository Guidelines

This repository is a Flutter package that provides Moon Design System headless UI core widgets.

## Project Structure & Module Organization
- `lib/` Public API entry at `lib/moon_core.dart` (barrel exports). Implementation lives in `lib/src/**` using snake_case files.
- `test/` Widget and unit tests (`*_test.dart`).
- `example/` Runnable example app for manual verification across platforms.
- Tooling: `analysis_options.yaml` (lints), `.editorconfig` (80-char line length), `pubspec.yaml` (SDK and deps).

## Build, Test, and Development Commands
- Install deps: `flutter pub get`
- Analyze lints: `dart analyze`
- Format code: `dart format .`
- Run all tests: `flutter test -r expanded`
- Coverage (optional): `flutter test --coverage`
- Run example app: `cd example && flutter run` (e.g., `-d chrome` for web)

## Coding Style & Naming Conventions
- Dart style, 2-space indent, max line length 80.
- Files: `snake_case.dart`; Classes: `PascalCase`; methods/fields/variables: `lowerCamelCase`; enum values: `lowerCamelCase`.
- Keep public exports organized in `lib/moon_core.dart`; new components live under `lib/src/` and are exported through the barrel.
- Prefer trailing commas for multi-line args to keep diffs clean.

## Testing Guidelines
- IMPORTANT: Refer to `.llms/tests.xml`
- Framework: `flutter_test` with `testWidgets` for UI and `group` for suites.
- File names: `*_test.dart`; keep test names imperative and focused (e.g., "toggles on tap").
- Aim to cover states, interactions, and accessibility. Use keys and finders for stable selectors.
- Run `flutter test` locally; ensure no analyzer errors (`dart analyze`).

## Commit & Pull Request Guidelines
- Commits: imperative mood, concise scope (e.g., "Add animated opacity modifier"). Optional ticket tag: `[MDS-1234]` and/or PR refs `(#NN)` when relevant.
- PRs: clear description, linked issue/ticket, before/after screenshots for UI, test updates, and `CHANGELOG.md` entry for user-visible changes.
- CI expectations: build passes, tests green, no new analyzer warnings.

## Security & Configuration Tips
- Do not commit secrets or generated files. Common generated patterns (`**/*.g.dart`, `**/*.freezed.dart`, etc.) are excluded by analyzer.
- Respect SDK constraints in `pubspec.yaml` (Dart `>=3.9.0`, Flutter `>=3.35.0`).

## Agent-Specific Notes
- Scope: these guidelines apply repo-wide. Since we are migrating to a modern v2 version of the `mix` package breaking changes are fine and we don't care about backwards compatibility. When adding APIs, update exports and tests in the same PR.

# ESSENTIAL!!!
- You can and should make liberal usage of the local Dart MCP!!!
- This projects foundation is a package called `mix` which we are using as a GH repository dependency as it is currently in beta. All documentation related to usage of `mix`, it's patterns, migration paths etc are included in the `.llms` directory, especially in the file `examples.xml`. Do note that the file `tests.xml` is huge (ca 50000 lines), yet it contains all the tests in the `mix` package and thus can offer insights into more advanced patterns. 