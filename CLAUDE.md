# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Moon Design System headless UI core widgets for Flutter. This library provides unstyled, accessible UI components that can be styled using the Mix styling system.

## Development Commands

### Build and Dependencies
```bash
# Install dependencies
flutter pub get

# Generate code (if using mix_generator)
dart run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Run a specific test
flutter test test/<test_file_name>.dart

# Analyze code
flutter analyze

# Format code
dart format .
```

### Example App
```bash
# Navigate to example directory
cd example

# Run the example app
flutter run

# Install dependencies for example
flutter pub get
```

## Architecture

### Core Structure
- `lib/moon_core.dart` - Main library export file containing all public APIs
- `lib/src/widgets/` - Contains all widget implementations
- `lib/src/widgets/common/` - Base widgets that other components inherit from
- `lib/src/mix/` - Mix styling system integrations and utilities
- `lib/src/utils/` - Utility functions and extensions

### Key Base Widgets
1. **MoonBaseInteractiveWidget** - Base for interactive components (buttons, chips, etc.)
2. **MoonBaseOverlayWidget** - Base for overlay components (tooltips, modals, etc.)
3. **MoonBaseSingleSelectWidget** - Base for single selection components
4. **MoonBaseMultiSelectWidget** - Base for multi-selection components

## Code Conventions

### Import Organization
1. Flutter imports first
2. Package imports (mix, mix_annotations)
3. Relative imports for internal modules

### Widget Naming
- All widgets prefixed with `Moon` (e.g., `MoonAccordion`, `MoonAlert`)
- Base widgets include `Base` in name (e.g., `MoonBaseInteractiveWidget`)

### Testing
- Each widget has corresponding test file in `test/` directory
- Test files follow pattern: `<widget_name>_test.dart`
- Use Flutter's testing framework conventions

## Dependencies

### Core Dependencies
- **mix**: Git dependency from https://github.com/btwld/mix.git (styling system)
- **mix_annotations**: Version 1.7.0 (code generation annotations)
- **collection**: Standard Dart collection utilities

### Dev Dependencies
- **mix_generator**: For Mix-related code generation
- **build_runner**: For running code generation
- **flutter_lints**: For code analysis

## Important Notes

1. This is a headless UI library - widgets are intentionally unstyled
2. All styling should be done through Mix's Style system
3. The library follows strict type checking (see analysis_options.yaml)
4. Example app in `example/` directory shows usage patterns
5. Currently on branch `mix_to_v2` migrating to Mix v2

# ESSENTIAL!!!
- You can and should make liberal usage of the local Dart MCP!!!
- This projects foundation is a package called `mix` which we are using as a dependency. All documentation related to usage of `mix`, it's patterns, migration paths etc are included in the `.llms` directory, especially in the file `examples.xml`. Do note that the file `tests.xml` is huge (ca 50000 lines), yet it contains all the tests in the `mix` package and thus can offer insights into more advanced patterns. 