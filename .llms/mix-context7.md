================
CODE SNIPPETS
================
TITLE: Install Mix Package (Bash)
DESCRIPTION: Installs the Mix library into your Flutter project using the Flutter package manager.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/getting-started.mdx#_snippet_0

LANGUAGE: bash
CODE:
```
flutter pub add mix
```

--------------------------------

TITLE: Run Fumadocs Development Server
DESCRIPTION: Navigate into the newly created documentation directory and start the development server to preview the site locally.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_2

LANGUAGE: bash
CODE:
```
cd docs
npm run dev
```

--------------------------------

TITLE: Token Reference Example Flow
DESCRIPTION: Provides an example of the token reference flow, demonstrating how a `ColorToken` is used to create a `ColorRef`, applied in styling, and then resolved by `MixScope` to its actual `Color` value.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_18

LANGUAGE: dart
CODE:
```
// Example resolution flow
const primaryColor = ColorToken('primary');

// 1. Create reference
final colorRef = primaryColor(); // Returns ColorRef

// 2. Use in styling 
$box.color(colorRef)

// 3. During resolution, token is extracted and resolved
// colorRef contains Prop.token(primaryColor)
// MixScope resolves primaryColor to actual Color value
```

--------------------------------

TITLE: Build and Test Fumadocs Documentation Locally
DESCRIPTION: Lists the bash commands to build the documentation, start a local server for testing, and verifies various aspects of the documentation site.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_16

LANGUAGE: bash
CODE:
```
npm run build
npm start
```

--------------------------------

TITLE: Create First Mix Widget (Dart)
DESCRIPTION: Demonstrates creating a basic Flutter widget using Mix for styling, including setting dimensions, color, borders, and text styles.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/getting-started.mdx#_snippet_2

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cardStyle = BoxStyler()
        .height(100)
        .width(240)
        .color(Colors.blue)
        .borderRounded(12)
        .borderAll(color: Colors.black, width: 1, style: BorderStyle.solid);

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Box(
            style: cardStyle,
            child: StyledText(
              'Hello Mix',
              style: TextStyler().color(Colors.white).fontSize(18),
            ),
          ),
        ),
      ),
    );
  }
}
```

--------------------------------

TITLE: Basic MixScope Setup with Typed Token Maps
DESCRIPTION: Illustrates the fundamental setup of MixScope by providing typed maps for various token categories such as colors, spaces, text styles, and shadows. This method allows for explicit definition of token types and their corresponding values.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_1

LANGUAGE: dart
CODE:
```
MixScope(
  colors: {
    ColorToken('brand.primary'): Colors.blue,
  },
  spaces: {
    SpaceToken('space.md'): 16.0,
  },
  doubles: {
    DoubleToken('elevation.card'): 2.0,
  },
  radii: {
    RadiusToken('radius.pill'): const Radius.circular(20),
  },
  textStyles: {
    TextStyleToken('text.h1'): const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  },
  fontWeights: {
    FontWeightToken('weight.semibold'): FontWeight.w600,
  },
  borders: {
    BorderSideToken('border.default'): const BorderSide(width: 1),
  },
  shadows: {
    ShadowToken('shadow.sm'): const [Shadow(blurRadius: 2, offset: Offset(0, 1))],
  },
  boxShadows: {
    BoxShadowToken('shadow.card'): const [
      BoxShadow(blurRadius: 8, spreadRadius: 0, offset: Offset(0, 4)),
    ],
  },
  child: MyApp(),
)
```

--------------------------------

TITLE: Install Latest Fumadocs Packages
DESCRIPTION: Command to install or update the latest versions of Fumadocs packages, including fumadocs-ui, fumadocs-core, and fumadocs-mdx.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_20

LANGUAGE: bash
CODE:
```
npm install fumadocs-ui@latest fumadocs-core@latest fumadocs-mdx@latest
```

--------------------------------

TITLE: Reuse Styles with Mix (Dart)
DESCRIPTION: Shows how to define a reusable style with Mix and apply it to multiple widgets, demonstrating style modification for different instances.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/getting-started.mdx#_snippet_3

LANGUAGE: dart
CODE:
```
final primaryCard = BoxStyler().color(Colors.blue).borderRounded(12);

final box = Box(style: primaryCard, child: StyledText('Primary'));

final box2 = Box(
  style: primaryCard.color(Colors.green),
  child: StyledText('Success'),
);
```

--------------------------------

TITLE: Run Flutter Examples
DESCRIPTION: Navigates to the examples directory and runs the flutter example application. This verifies that example usage is correct.

SOURCE: https://github.com/btwld/mix/blob/main/mix_architecture_consolidation_plan.md#_snippet_28

LANGUAGE: bash
CODE:
```
cd examples && flutter run
```

--------------------------------

TITLE: Basic Theme Setup with MixScope
DESCRIPTION: Configures the application's theme by providing custom colors, spaces, text styles, and radii through the MixScope widget. This sets up the foundational theme data for the application.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_11

LANGUAGE: dart
CODE:
```
void main() {
  runApp(
    MixScope(
      colors: {
        primaryColor: Colors.blue,
      },
      spaces: {
        largeSpace: 24.0,
      },
      textStyles: {
        headingStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      },
      radii: {
        roundedCorner: Radius.circular(8),
      },
      child: MyApp(),
    ),
  );
}
```

--------------------------------

TITLE: Migrate Theme Setup (Dart)
DESCRIPTION: Compares the old and new methods for setting up theme data in `MixScope`. The new approach directly uses named parameters like `colors` and `spaces`, replacing the `MixScopeData.static` constructor.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_29

LANGUAGE: dart
CODE:
```
// Old (remove)
MixScope(
  data: MixScopeData.static(tokens: {...}),
  child: MyApp(),
)

// New
MixScope(
  colors: {primaryColor: Colors.blue},
  spaces: {largeSpace: 24.0},
  child: MyApp(),
)
```

--------------------------------

TITLE: Run Mix Examples Gallery (Bash)
DESCRIPTION: Command to run all Mix framework examples in an interactive gallery mode using the Flutter CLI.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/example/README.md#_snippet_3

LANGUAGE: bash
CODE:
```
flutter run lib/main.dart
```

--------------------------------

TITLE: Import Mix Library (Dart)
DESCRIPTION: Imports the necessary Mix library components into your Dart code for use in your Flutter application.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/getting-started.mdx#_snippet_1

LANGUAGE: dart
CODE:
```
import 'package:mix/mix.dart';
```

--------------------------------

TITLE: Run Individual Mix Example (Bash)
DESCRIPTION: Command to run a specific Mix framework example, such as a simple box or an animation, using the Flutter CLI.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/example/README.md#_snippet_4

LANGUAGE: bash
CODE:
```
# Widget examples
flutter run lib/api/widgets/box/simple_box.dart
flutter run lib/api/widgets/box/gradient_box.dart

# Animation examples
flutter run lib/api/animation/hover_scale_animation.dart
flutter run lib/api/animation/spring_animation.dart
```

--------------------------------

TITLE: Generic Token Map Setup with MixScope
DESCRIPTION: Sets up the application theme using a generic token map within MixScope, allowing for a flexible approach to defining various theme properties like colors, spaces, text styles, and radii in a single map.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_12

LANGUAGE: dart
CODE:
```
void main() {
  runApp(
    MixScope(
      tokens: {
        primaryColor: Colors.blue,
        largeSpace: 24.0,
        headingStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        roundedCorner: Radius.circular(8),
      },
      child: MyApp(),
    ),
  );
}
```

--------------------------------

TITLE: Fumadocs meta.json Structure
DESCRIPTION: An example of a Fumadocs `meta.json` file, demonstrating the new structure with a `title` and a `pages` array that includes separators and page references.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_6

LANGUAGE: json
CODE:
```
{
  "title": "Mix v1 Documentation",
  "pages": [
    {
      "type": "separator",
      "title": "Overview"
    },
    "overview",
    {
      "type": "separator",
      "title": "Guides"
    },
    "guides",
    {
      "type": "separator",
      "title": "Tutorials"
    },
    "tutorials",
    {
      "type": "separator",
      "title": "Widgets"
    },
    "widgets",
    {
      "type": "separator",
      "title": "Utilities"
    },
    "utilities",
    {
      "type": "separator",
      "title": "Tools"
    },
    "tools"
  ]
}
```

--------------------------------

TITLE: Nextra _meta.json Structure
DESCRIPTION: An example of a Nextra `_meta.json` file, showcasing how separators and display children are defined for organizing documentation pages.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_5

LANGUAGE: json
CODE:
```
{
  "-- Overview": {
    "type": "separator",
    "title": "Overview"
  },
  "overview": {
    "title": "Overview",
    "display": "children"
  },
  "-- Guides": {
    "type": "separator",
    "title": "Guides"
  },
  "guides": {
    "title": "Guides",
    "display": "children"
  }
}
```

--------------------------------

TITLE: MixScope Setup with Generic Tokens Map
DESCRIPTION: Shows an alternative method for setting up MixScope using a single generic `tokens:` map. This approach consolidates different token types into one map, simplifying the declaration process when dealing with mixed token types.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_2

LANGUAGE: dart
CODE:
```
MixScope(
  tokens: {
    ColorToken('brand.primary'): Colors.blue,
    SpaceToken('space.md'): 16.0,
    ShadowToken('shadow.sm'): const [Shadow(blurRadius: 2, offset: Offset(0, 1))],
  },
  child: MyApp(),
)
```

--------------------------------

TITLE: Semantic Tokens (Dart)
DESCRIPTION: Illustrates the use of semantic naming for tokens to improve maintainability. Examples include semantic color tokens like `actionPrimary` and layout-related space tokens like `contentPadding`.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_28

LANGUAGE: dart
CODE:
```
// Semantic naming for better maintainability
const actionPrimary = ColorToken('action.primary');
const actionSecondary = ColorToken('action.secondary');
const actionDanger = ColorToken('action.danger');

const contentPadding = SpaceToken('layout.content.padding');
const sectionSpacing = SpaceToken('layout.section.spacing');
```

--------------------------------

TITLE: Basic and Advanced Icon Styling Examples
DESCRIPTION: Demonstrates how to apply various styling properties like color, size, weight, fill, and shadow using the Mix fluent API. Includes examples for simple and complex icon configurations.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_style_api.md#_snippet_54

LANGUAGE: dart
CODE:
```
// Simple icon styling
final basicIcon = $icon
  .color.blue()
  .size(24);

// Advanced icon styling
final fancyIcon = $icon
  .color.red.shade600()
  .size(32)
  .weight(500)
  .fill(0.8)
  .shadow.medium()
  .animate(AnimationConfig(duration: Duration(milliseconds: 200)));

// Variable font features
final variableIcon = $icon
  .size(28)
  .color.green()
  .weight(600)
  .grade(200)
  .opticalSize(24)
  .fill(1.0);

// Icon with multiple shadows
final shadowedIcon = $icon
  .color.purple()
  .size(20)
  .shadows([
    ShadowMix(
      color: Colors.black26,
      offset: Offset(1, 1),
      blurRadius: 2,
    ),
    ShadowMix(
      color: Colors.purple.withOpacity(0.3),
      offset: Offset(2, 2),
      blurRadius: 4,
    ),
  ]);
```

--------------------------------

TITLE: MixScope Setup with Material Integration
DESCRIPTION: Demonstrates how to integrate MixScope with Material Design themes using `MixScope.withMaterial`. This allows the usage of Material tokens directly and provides an option to add or override custom tokens alongside Material ones.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_3

LANGUAGE: dart
CODE:
```
MixScope.withMaterial(
  // Optionally add/override custom tokens
  colors: {
    ColorToken('brand.primary'): Colors.indigo,
  },
  child: MyApp(),
)
```

--------------------------------

TITLE: Widget Testing with MixScope (Dart)
DESCRIPTION: Shows how to test widgets that depend on `MixScope`. This involves providing mock tokens for colors and spaces within the `MixScope` widget during the test setup.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_23

LANGUAGE: dart
CODE:
```
await tester.pumpWidget(
  MixScope(
    colors: {
      AppTokens.primary: Colors.red,
    },
    spaces: {
      AppTokens.md: 20.0,
    },
    child: MyWidget(),
  ),
);
```

--------------------------------

TITLE: Mix Dot Notation Example (Dart)
DESCRIPTION: Illustrates the simplified dot notation syntax for styling widgets in Mix, contrasting it with the older cascade notation.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/example/README.md#_snippet_2

LANGUAGE: dart
CODE:
```
// Instead of: $box.height(100)..width(100)
// You can write:
Style.box(
  .height(100)
  .width(100)
  .color(Colors.blue)
)
```

--------------------------------

TITLE: Create Fumadocs App using NPM
DESCRIPTION: Initialize a new Fumadocs documentation project using the official npm create command.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_1

LANGUAGE: bash
CODE:
```
npm create fumadocs-app docs
```

--------------------------------

TITLE: Migrate Testing Patterns in Dart
DESCRIPTION: Demonstrates the transition from old, deprecated testing patterns to the new unified `resolvesTo` approach in Dart for testing properties, mix types, and attributes. Includes an example of testing token properties with a build context.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/test/helpers/testing_guide.md#_snippet_9

LANGUAGE: dart
CODE:
```
// Old way (deprecated patterns)
expect(prop.getValue(), Colors.red);           // Direct access
expect(prop, hasValue(Colors.red));           // Old matchers
expect(mix.resolve(context), isA<Border>());  // Manual resolution

// New unified approach
expect(prop, resolvesTo(Colors.red));         // Works for Props
expect(mix, resolvesTo(expectedBorder));      // Works for Mix types
expect(attribute, resolvesTo(expectedSpec));  // Works for Attributes

// For token testing with context
final context = MockBuildContext(
  mixScopeData: MixScopeData.static(tokens: {token: value}),
);
expect(tokenProp, resolvesTo(expected, context: context));
```

--------------------------------

TITLE: Testing Box Size Resolution
DESCRIPTION: Example of how to test the resolved constraints of a BoxMix after setting its size.

SOURCE: https://github.com/btwld/mix/blob/main/guides/api-composition-guidelines.md#_snippet_6

LANGUAGE: dart
CODE:
```
final box = BoxMix().size(200, 200);

expect(box.$constraints, resolvesTo(const BoxConstraints.tightFor(width: 200, height: 200), context: context));
```

--------------------------------

TITLE: Create Version Directories (Bash)
DESCRIPTION: Bash commands to create the necessary version-specific directories for Fumadocs content.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_7

LANGUAGE: bash
CODE:
```
mkdir -p docs/content/docs/v1
mkdir -p docs/content/docs/v2
```

--------------------------------

TITLE: Basic Styling Examples
DESCRIPTION: Provides examples of simple, single-purpose styling using Mix utilities for common properties like color, font weight, and icon size.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/spec_util_api.md#_snippet_20

LANGUAGE: dart
CODE:
```
// Simple, single-purpose styling
final redBox = $box.color.red();
final boldText = $text.fontWeight.bold();
final largeIcon = $icon.size(32);
```

--------------------------------

TITLE: StackBoxStyler Constructor Examples
DESCRIPTION: Demonstrates creating styled stack containers using the StackBoxStyler constructor with various decoration, padding, margin, and stack behavior properties. Includes examples for basic styled containers and cards with overlays.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_37

LANGUAGE: dart
CODE:
```
// Basic styled stack container
final styledStack = StackBoxStyler(
  // Box styling
  decoration: DecorationMix(
    color: Colors.blue.shade100,
    borderRadius: BorderRadiusGeometryMix.circular(12),
    border: BoxBorderMix.all(color: Colors.blue.shade300),
  ),
  padding: EdgeInsetsGeometryMix.all(16),
  margin: EdgeInsetsGeometryMix.only(bottom: 8),
  // Stack behavior
  stackAlignment: Alignment.center,
  fit: StackFit.expand,
);

// Card with overlay
final cardWithOverlay = StackBoxStyler(
  decoration: DecorationMix(
    color: Colors.white,
    borderRadius: BorderRadiusGeometryMix.circular(8),
    boxShadow: [
      BoxShadowMix(
        color: Colors.black26,
        offset: Offset(0, 2),
        blurRadius: 4,
      ),
    ],
  ),
  padding: EdgeInsetsGeometryMix.zero,
  stackAlignment: Alignment.topRight,
  fit: StackFit.loose,
  clipBehavior: Clip.antiAlias,
);
```

--------------------------------

TITLE: Token Resolution Testing (Dart)
DESCRIPTION: Provides an example of testing if a token resolves correctly within the `MixScope` context. It uses `testWidgets` to create a widget tree with a `MixScope` and asserts the resolved token value.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_24

LANGUAGE: dart
CODE:
```
testWidgets('token resolves correctly', (tester) async {
  const token = ColorToken('test');
  
  await tester.pumpWidget(
    MixScope(
      colors: {token: Colors.blue},
      child: Builder(
        builder: (context) {
          final resolved = MixScope.tokenOf(token, context);
          expect(resolved, equals(Colors.blue));
          return Container();
        },
      ),
    ),
  );
});
```

--------------------------------

TITLE: Phase Animations in Mix
DESCRIPTION: Demonstrates phase animations based on a trigger, defining different styles and animation configurations for each phase.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/example/README.md#_snippet_8

LANGUAGE: dart
CODE:
```
.phaseAnimation(
  trigger: _isExpanded,
  phases: AnimationPhases.values,
  styleBuilder: (phase, style) => switch (phase) {
    .initial => style.scale(1),
    .compress => style.scale(0.75),
    .expanded => style.scale(1.25),
  },
  configBuilder: (phase) => switch (phase) {
    .initial => .decelerate(200.ms),
    .compress => .decelerate(100.ms),
    .expanded => .bounceOut(600.ms),
  },
)
```

--------------------------------

TITLE: Deploy and Verify Fumadocs Documentation
DESCRIPTION: Outlines the git commands for committing and pushing changes, and advises on monitoring the Vercel deployment dashboard and verifying the live site functionality.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_17

LANGUAGE: bash
CODE:
```
git add .
git commit -m "Add Fumadocs documentation"
git push origin main
```

--------------------------------

TITLE: SpaceRef Extension Type Example in Dart
DESCRIPTION: An example of an extension type `SpaceRef` used for primitive `double` values, specifically for spacing and sizing tokens. It includes a `token` static method to create unique reference values and register tokens.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_8

LANGUAGE: dart
CODE:
```
// Extension type example
extension type const SpaceRef(double _value) implements double {
  static SpaceRef token(MixToken<double> token) {
    // Creates unique reference value and registers token
    final hash = token.hashCode.abs() % 100000;
    final ref = SpaceRef(-(0.000001 + hash * 0.000001));
    _tokenRegistry[ref] = token;
    return ref;
  }
}
```

--------------------------------

TITLE: Basic Image Styling Example
DESCRIPTION: Demonstrates basic image styling using the global utility method $image, setting width and height with a cover fit.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_67

LANGUAGE: dart
CODE:
```
final basicImage = $image
  .width(200)
  .height(150)
  .fit.cover();
```

--------------------------------

TITLE: Basic Icon Styling Example
DESCRIPTION: Demonstrates basic icon styling, including setting color and size. Shows how to chain multiple styling methods for a complete icon definition.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_util_api.md#_snippet_20

LANGUAGE: dart
CODE:
```
final basicIcon = $icon
  .color.blue()
  .size(24);

final styledIcon = $icon
  .size(32)
  .color.red()
  .weight.bold();
```

--------------------------------

TITLE: Stack: Alignment and Fit
DESCRIPTION: Demonstrates configuring StackMix properties like alignment and fit using chaining or constructor arguments.

SOURCE: https://github.com/btwld/mix/blob/main/guides/api-composition-guidelines.md#_snippet_4

LANGUAGE: dart
CODE:
```
final stack = StackMix().alignment(Alignment.center).fit(StackFit.expand);
// or
final stackShort = StackMix.alignment(Alignment.center).fit(StackFit.expand);
// or
final stackConstructor = StackMix(alignment: Alignment.center, fit: StackFit.expand);
```

--------------------------------

TITLE: Accessing Tokens in Widget/Utility Code
DESCRIPTION: Provides examples of how to retrieve token values within widget or utility code using `MixScope.of(context)` to get the scope instance and then calling `getToken()` with the token reference. It also shows the direct resolution method on the token itself.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_4

LANGUAGE: dart
CODE:
```
final scope = MixScope.of(context, 'tokens');
final brand = scope.getToken(ColorToken('brand.primary'), context);

// Or directly on the token:
final brand = ColorToken('brand.primary').resolve(context);
```

--------------------------------

TITLE: Token Resolution Flow
DESCRIPTION: Visualizes the process of token resolution, starting from a `MixToken`, creating a `TokenRef` via the `call()` method, and finally resolving to the actual value using `MixScope.tokenOf<T>()`.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_17

LANGUAGE: dart
CODE:
```
// Token resolution flow
MixToken<T> 
  → token() creates TokenRef/ExtensionType
  → MixScope.tokenOf<T>(token, context)
  → T (resolved value)
```

--------------------------------

TITLE: Navigate to Repository Root
DESCRIPTION: Change the current directory to the root of your project repository.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_0

LANGUAGE: bash
CODE:
```
cd /path/to/your/mix/project
```

--------------------------------

TITLE: FlexBoxStyler Constructor Usage Example
DESCRIPTION: Demonstrates how to instantiate and configure `FlexBoxStyler` directly using its constructor. This example sets color, padding, border radius, direction, main axis alignment, and spacing.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flexbox/flexbox_style_api.md#_snippet_30

LANGUAGE: dart
CODE:
```
final flexboxStyle = FlexBoxStyler()
  .color(Colors.blue.shade100)
  .padding(EdgeInsetsGeometryMix.all(16))
  .borderRadius(BorderRadiusGeometryMix.circular(8))
  .direction(Axis.horizontal)
  .mainAxisAlignment(MainAxisAlignment.spaceBetween)
  .spacing(12)
;
```

--------------------------------

TITLE: Basic Styling Pattern with Mix
DESCRIPTION: Demonstrates the basic styling pattern in Mix using the Style class and $box utility for common properties like padding, color, and border radius. It also shows how to apply this style to a Mix Box widget.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/ai.txt#_snippet_0

LANGUAGE: dart
CODE:
```
final style = Style(
    $box
        ..padding(16)
        ..color.blue()
        ..borderRadius(8),
  );

// Mix approach
Box( // Use Box instead of Container
  style: style,
  child: StyledText('Hello World'), // Use StyledText for consistent Mix styling
)
```

--------------------------------

TITLE: Animated Icons Example
DESCRIPTION: Provides examples of animating icons, including basic animations with duration and curve settings, and specialized animations like rotation with repeat functionality.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_util_api.md#_snippet_24

LANGUAGE: dart
CODE:
```
final animatedIcon = $icon
  .color.green()
  .size(24)
  .animate(AnimationConfig(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  ));

final transformIcon = $icon
  .color.purple()
  .size(28)
  .animate(AnimationConfig.rotation(
    duration: Duration(seconds: 2),
    repeat: true,
  ));
```

--------------------------------

TITLE: Migrate Nextra Components to Fumadocs UI
DESCRIPTION: Illustrates the conversion of Nextra components like <Steps> to their Fumadocs UI equivalents, including necessary import statements.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_10

LANGUAGE: mdx
CODE:
```
// Before (Nextra)
import { Steps } from "nextra/components";

<Steps>
### Installation
Run the following command...
</Steps>

// After (Fumadocs)
import { Step, Steps } from 'fumadocs-ui/components/steps';

<Steps>
<Step>

### Installation
Run the following command...

</Step>
</Steps>
```

--------------------------------

TITLE: Test Utility Function Creation - Dart
DESCRIPTION: Checks if a utility function correctly creates a Prop and resolves its value. This example uses a ColorUtility to create a Prop for a color.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/test/helpers/testing_guide.md#_snippet_6

LANGUAGE: dart
CODE:
```
test('utility function creates correct Prop and resolves', () {
  final colorUtility = ColorUtility(MockStyle.new);
  final attr = colorUtility(Colors.orange);
  
  // Test that it resolves correctly
  expect(attr.value, resolvesTo(Colors.orange));
});
```

--------------------------------

TITLE: Complex Icon Compositions Example
DESCRIPTION: Demonstrates advanced icon styling techniques, such as creating badge-like icons with backgrounds and decorations, and applying multiple custom shadows.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_util_api.md#_snippet_26

LANGUAGE: dart
CODE:
```
final badgeIcon = $icon
  .icon(Icons.notifications)
  .color.white()
  .size(18)
  .wrap.padding(EdgeInsets.all(8))
  .wrap.decoration(BoxDecoration(
    color: Colors.red,
    shape: BoxShape.circle,
  ));

final shadowIcon = $icon
  .color.white()
  .size(32)
  .shadows([
    Shadow(
      color: Colors.black26,
      offset: Offset(2, 2),
      blurRadius: 4,
    ),
    Shadow(
      color: Colors.black12,
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ]);
```

--------------------------------

TITLE: Basic Box Styling with Mix
DESCRIPTION: Demonstrates basic box styling using Mix's fluent API. It sets properties like color, height, width, and border-radius.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/example/README.md#_snippet_5

LANGUAGE: dart
CODE:
```
final style = Style.box(
  .color(Colors.red)
  .height(100)
  .width(100)
  .borderRadius(.circular(10))
);

Box(style: style);
```

--------------------------------

TITLE: Profile Avatar Styling Example
DESCRIPTION: Example of styling for a profile avatar, focusing on dimensions, fit, filter quality, and anti-aliasing.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_69

LANGUAGE: dart
CODE:
```
final avatarImage = $image
  .width(50)
  .height(50)
  .fit.cover()
  .filterQuality.high()
  .isAntiAlias(true);
```

--------------------------------

TITLE: Box: Min/Max Bounds
DESCRIPTION: Illustrates setting minimum and maximum width and height constraints for a BoxMix.

SOURCE: https://github.com/btwld/mix/blob/main/guides/api-composition-guidelines.md#_snippet_2

LANGUAGE: dart
CODE:
```
final resizable = BoxMix()
  .minWidth(120)
  .maxWidth(480)
  .minHeight(80);
```

--------------------------------

TITLE: Theme-Aware Icons Example
DESCRIPTION: Illustrates how icons can adapt to different themes (dark mode) and screen breakpoints, allowing for dynamic styling based on the environment.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_util_api.md#_snippet_25

LANGUAGE: dart
CODE:
```
final themeIcon = $icon
  .size(24)
  .color.black()
  .onDark($icon.color.white())
  .onBreakpoint(Breakpoint.md, $icon.size(28));

final contextIcon = $icon
  .color.primary()
  .size(20)
  .onPressed($icon.color.primary().shade700())
  .onDisabled($icon.color.grey().opacity.half());
```

--------------------------------

TITLE: Flutter Project pubspec.yaml Configuration
DESCRIPTION: Example configuration for the 'pubspec.yaml' file, showing the dependencies including 'mix' and 'mix_annotations', and development dependencies like 'mix_generator' and 'build_runner'.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/creating-a-widget.md#_snippet_2

LANGUAGE: yaml
CODE:
```
dependencies:
  flutter:
    sdk: flutter
  mix: ^1.0.0
  mix_annotations: ^1.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  mix_generator: ^1.0.0
  build_runner: ^2.0.0
```

--------------------------------

TITLE: ZBox Usage Example
DESCRIPTION: Demonstrates how to create and use the ZBox widget with various styling properties for layout and appearance. It requires a Style object with stack and box attributes.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/stack.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
ZBox(
  style: Style(
    $stack.alignment.bottomLeft(),
    $stack.fit.loose(),
    $box.width(300),
    $box.height(300),
    $box.color.blue(),
  ),
  children: [...],
);
```

--------------------------------

TITLE: Card-Style Flex Layout Example
DESCRIPTION: Shows an example of creating a card-like flex layout using the global utility `$flexbox`. It configures background color, border, border radius, padding, direction, cross-axis alignment, and spacing.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flexbox/flexbox_style_api.md#_snippet_28

LANGUAGE: dart
CODE:
```
final cardLayout = $flexbox
  .color.white()
  .border.all(color: Colors.grey.shade300)
  .borderRadius(12)
  .padding.all(20)
  .direction(Axis.vertical)
  .crossAxisAlignment.stretch()
  .spacing(16);
```

--------------------------------

TITLE: Add Mix to Flutter Project Dependencies (Bash)
DESCRIPTION: Command to add the Mix framework (version 2.0.0-dev.1 or higher) to a Flutter project's dependencies using the Flutter CLI.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/example/README.md#_snippet_1

LANGUAGE: bash
CODE:
```
# Create a new Flutter project
flutter create my_mix_app
cd my_mix_app

# Add Mix 2.0 to your dependencies
flutter pub add mix:^2.0.0-dev.1
```

--------------------------------

TITLE: Fragment Composition using merge()
DESCRIPTION: Shows how to compose reusable UI fragments by merging multiple BoxMix instances.

SOURCE: https://github.com/btwld/mix/blob/main/guides/api-composition-guidelines.md#_snippet_5

LANGUAGE: dart
CODE:
```
final base = BoxMix().padding(EdgeInsetsMix.all(16));
final elevated = BoxMix().borderRadius(BorderRadiusMix.circular(12));
final card = base.merge(elevated); // Use merge() when composing fragments
```

--------------------------------

TITLE: Responsive Tokens (Dart)
DESCRIPTION: Shows how to create responsive spacing values based on screen width. The `ResponsiveSpacing` class provides a `getSpacing` method that scales token values dynamically.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_27

LANGUAGE: dart
CODE:
```
class ResponsiveSpacing {
  static double getSpacing(BuildContext context, SpaceToken token) {
    final width = MediaQuery.of(context).size.width;
    final baseValue = MixScope.tokenOf(token, context);
    
    // Scale spacing based on screen size
    if (width > 600) {
      return baseValue * 1.5;
    }
    return baseValue;
  }
}
```

--------------------------------

TITLE: ImageStyler Constructor Usage Example
DESCRIPTION: Shows how to create and configure an ImageStyler using its constructor, applying various styling properties like dimensions, fit, alignment, color, and animation.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_72

LANGUAGE: dart
CODE:
```
final imageStyle = ImageStyler()
  .width(200)
  .height(150)
  .fit(BoxFit.cover)
  .alignment(Alignment.center)
  .color(Colors.blue.withOpacity(0.3))
  .colorBlendMode(BlendMode.overlay)
  .filterQuality(FilterQuality.high)
  .isAntiAlias(true)
  .animate(AnimationConfig(duration: Duration(milliseconds: 500)));
```

--------------------------------

TITLE: Add Mix Development Packages
DESCRIPTION: Installs 'mix_generator' and 'build_runner' as development dependencies. These are required for code generation and building the project when using 'mix'.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/creating-a-widget.md#_snippet_1

LANGUAGE: bash
CODE:
```
flutter pub add --dev mix_generator build_runner
```

--------------------------------

TITLE: Accessibility & Semantic Icons Example
DESCRIPTION: Demonstrates setting semantic labels for screen readers and enabling text scaling support for icons, enhancing accessibility.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_util_api.md#_snippet_23

LANGUAGE: dart
CODE:
```
final accessibleIcon = $icon
  .icon(Icons.home)
  .color.black()
  .size(24)
  .semanticsLabel('Navigate to home');

final scalableIcon = $icon
  .color.blue()
  .size(20)
  .applyTextScaling.enabled();
```

--------------------------------

TITLE: Repeating Pattern Image Example
DESCRIPTION: Example of creating a repeating pattern image by setting repeat, fit to none, and aligning to the top left.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_71

LANGUAGE: dart
CODE:
```
final patternImage = $image
  .repeat.repeat()
  .fit.none()
  .alignment.topLeft();
```

--------------------------------

TITLE: Material Design Icon Styling Example
DESCRIPTION: Illustrates styling Material Design icons, including setting icon data, color, size, weight, and applying effects like fill and shadows.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_util_api.md#_snippet_21

LANGUAGE: dart
CODE:
```
final materialIcon = $icon
  .icon(Icons.favorite)
  .color.red()
  .size(24)
  .weight.regular()
  .grade.normal();

final variableIcon = $icon
  .icon(Icons.star_outlined)
  .color.amber()
  .size(32)
  .weight.medium()
  .fill.half()
  .shadows.medium();
```

--------------------------------

TITLE: Configure Root Folders for Multi-Version Docs (JSON)
DESCRIPTION: Defines the structure for multi-version documentation by configuring root folders and specifying metadata for each version (e.g., v1, v2) using JSON files.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_12

LANGUAGE: json
CODE:
```
{
  "title": "Mix v1",
  "description": "Current stable version",
  "root": true,
  "pages": [
    "index",
    "overview",
    "guides",
    "utilities",
    "widgets",
    "tutorials",
    "tools"
  ]
}
```

LANGUAGE: json
CODE:
```
{
  "title": "Mix v2",
  "description": "Next major version",
  "root": true, 
  "pages": [
    "index",
    "migration",
    "new-features",
    "breaking-changes"
  ]
}
```

--------------------------------

TITLE: Text Layout Control and Scaling Example
DESCRIPTION: Shows how to control text layout properties like alignment and overflow, and demonstrates responsive text scaling using textScaler for accessibility. This example includes setting font size, alignment to center, text overflow to ellipsis, and line height.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_util_api.md#_snippet_2

LANGUAGE: dart
CODE:
```
final layoutText = $text
  .fontSize(14)
  .color.black87()
  .textAlign.center()
  .textOverflow.ellipsis()
  .height(1.5);

final accessibleText = $text
  .fontSize(16)
  .textScaler.linear(1.2)
  .color.grey().shade800();
```

--------------------------------

TITLE: MockBuildContext for Resolution
DESCRIPTION: Illustrates the usage of `MockBuildContext` to provide a context required for attribute and token resolution. It shows how to set up `MixScopeData` for token resolution.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/test/helpers/testing_guide.md#_snippet_1

LANGUAGE: dart
CODE:
```
test('resolving requires context', () {
  final attribute = SomeAttribute(color: Prop.value(Colors.red));
  final context = MockBuildContext();
  final resolved = attribute.resolve(context);
  
  expect(resolved.color, Colors.red);
});

test('tokens need context with scope data', () {
  const token = MixToken<Color>('surface');
  final context = MockBuildContext(
    mixScopeData: MixScopeData.static(
      tokens: {token: Colors.white},
    ),
  );
  
  final tokenProp = Prop.token(token);
  expect(tokenProp, resolvesTo(Colors.white, context: context));
});
```

--------------------------------

TITLE: Box: From Existing Size
DESCRIPTION: Explains how to create a BoxMix using an existing Size object passed via the constructor with BoxConstraintsMix.

SOURCE: https://github.com/btwld/mix/blob/main/guides/api-composition-guidelines.md#_snippet_3

LANGUAGE: dart
CODE:
```
final size = const Size(240, 160);
final boxFromSize = BoxMix(constraints: BoxConstraintsMix.size(size));
```

--------------------------------

TITLE: Testing Utilities with SpecStyle
DESCRIPTION: Demonstrates how to use `MockStyle` for testing utility functions that require a `Style<T>` builder. It also shows how `Prop<T>`'s merge strategy affects the outcome.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/test/helpers/testing_guide.md#_snippet_2

LANGUAGE: dart
CODE:
```
test('utility creates correct attributes', () {
  // For utility functions that take Style<T> builder
  final colorUtility = ColorUtility(MockStyle.new);
  final attr = colorUtility(Colors.red);
  
  expect(attr.value, resolvesTo(Colors.red));
});

test('utility attributes merge correctly', () {
  final first = MockStyle(Prop.value(Colors.red));
  final second = MockStyle(Prop.value(Colors.blue));
  
  final merged = first.merge(second);
  // Prop<T> uses replacement merge, so merged resolves to the second color
  expect(merged.value, resolvesTo(Colors.blue));
});
```

--------------------------------

TITLE: Testing Stack Specification Resolution
DESCRIPTION: Demonstrates testing the resolved properties of a StackMix, such as alignment and fit.

SOURCE: https://github.com/btwld/mix/blob/main/guides/api-composition-guidelines.md#_snippet_7

LANGUAGE: dart
CODE:
```
final stack = StackMix().alignment(Alignment.center).fit(StackFit.expand);

expect(stack, resolvesTo(StackSpec(alignment: Alignment.center, fit: StackFit.expand), context: context));
```

--------------------------------

TITLE: Basic Text Styling Example
DESCRIPTION: Demonstrates basic text styling including setting color and font size for simple text, and applying bold font weight with a custom font family for more emphasized text.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_util_api.md#_snippet_0

LANGUAGE: dart
CODE:
```
final basicText = $text
  .color.blue()
  .fontSize(16);

final boldText = $text
  .fontWeight.bold()
  .fontFamily('Roboto')
  .fontSize(18);
```

--------------------------------

TITLE: Creating Type-Safe Tokens in Dart
DESCRIPTION: Examples of creating type-safe design tokens using specific token classes like ColorToken, SpaceToken, TextStyleToken, RadiusToken, and BoxShadowToken. These tokens are defined with unique string names.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_10

LANGUAGE: dart
CODE:
```
// Create type-safe tokens using specific token types
const primaryColor = ColorToken('primary');
const largeSpace = SpaceToken('large');
const headingStyle = TextStyleToken('heading');
const roundedCorner = RadiusToken('rounded');
const cardShadow = BoxShadowToken('card.shadow');
```

--------------------------------

TITLE: Add Mix Packages to Flutter Project
DESCRIPTION: Installs the 'mix' and 'mix_annotations' packages for Flutter projects. These are essential for building design system components with the 'mix' framework.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/creating-a-widget.md#_snippet_0

LANGUAGE: bash
CODE:
```
flutter pub add mix mix_annotations
```

--------------------------------

TITLE: Conditional Styling Examples
DESCRIPTION: Shows how to apply responsive and state-based styling using methods like `onBreakpoint`, `onDark`, and `onHovered` to create dynamic UI elements.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/spec_util_api.md#_snippet_22

LANGUAGE: dart
CODE:
```
// Responsive and state-based styling
final responsiveText = $text
  .fontSize(16)
  .color.black()
  .onBreakpoint(Breakpoint.md, $text.fontSize(18))
  .onDark($text.color.white())
  .onHovered($text.color.blue());
```

--------------------------------

TITLE: Theme-aware Components (Dart)
DESCRIPTION: Illustrates creating a theme-aware `StatelessWidget` using `MixScope`. The component, `ThemedContainer`, applies tokens for box color, padding, and border radius, making it adaptable to theme changes.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_25

LANGUAGE: dart
CODE:
```
class ThemedContainer extends StatelessWidget {
  const ThemedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Box(
      style: Style(
        $box.color.token(AppTokens.surface),
        $box.padding.all.token(AppTokens.md),
        $box.borderRadius.all.token(AppTokens.rounded),
      ),
      child: Text('Themed content'),
    );
  }
}
```

--------------------------------

TITLE: Customize Fumadocs Theme and Navigation
DESCRIPTION: Shows how to customize the Fumadocs documentation layout, including setting the page tree, title, logo, and external links for branding and navigation.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_15

LANGUAGE: typescript
CODE:
```
import { DocsLayout } from 'fumadocs-ui/layouts/docs';
import { source } from '@/lib/source';

export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <DocsLayout
      tree={source.pageTree}
      nav={{
        title: 'Mix Documentation',
        logo: <MixLogo />, // Your logo component
      }}
      links={[
        {
          text: 'GitHub',
          url: 'https://github.com/btwld/mix',
          external: true,
        },
        {
          text: 'Discord',
          url: 'https://discord.gg/Ycn6GV3m2k',
          external: true,
        },
      ]}>
      {children}
    </DocsLayout>
  );
}
```

--------------------------------

TITLE: MixToken<T> Abstract Class in Dart
DESCRIPTION: The abstract base class for all design tokens in the Mix framework. It includes methods for getting token references and resolving token values within a given context. It is type-safe and provides basic equality checks.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_0

LANGUAGE: dart
CODE:
```
abstract class MixToken<T> {
  final String name;
  const MixToken(this.name);
  
  /// Returns a token reference that can be used in styling
  T call() => getReferenceValue(this);
  
  /// Resolves token to actual value within the given context
  T resolve(BuildContext context) => MixScope.tokenOf(this, context);
  
  @override
  operator ==(Object other) => 
      identical(this, other) || (other is MixToken && other.name == name);
  
  @override
  int get hashCode => Object.hash(name, T);
}
```

--------------------------------

TITLE: Icon States and Effects Example
DESCRIPTION: Shows how to apply visual effects like opacity and blend modes, and how to manage interactive states like hover effects with style changes.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_util_api.md#_snippet_22

LANGUAGE: dart
CODE:
```
final effectIcon = $icon
  .color.blue()
  .size(24)
  .opacity.threeQuarter()
  .blendMode.multiply();

final interactiveIcon = $icon
  .color.grey()
  .size(20)
  .onHovered($icon.color.blue().scale(1.1));
```

--------------------------------

TITLE: Dart: Styling Text with Instance Methods
DESCRIPTION: Demonstrates using instance methods of a `TextStyler` class to apply various text styles like color, font size, font weight, and text decorations. Includes examples for basic, advanced, and minimalist styling.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_62

LANGUAGE: dart
CODE:
```
// Using mixin methods for convenience
final styledText = TextStyler()
  .color(Colors.blue)
  .fontSize(16)
  .fontWeight(FontWeight.bold)
  .letterSpacing(0.5)
  .height(1.4)
  .decoration(TextDecoration.underline)
  .decorationColor(Colors.blue)
  .textAlign(TextAlign.center)
  .maxLines(2)
  .overflow(TextOverflow.ellipsis);

// Text with advanced styling
final fancyText = TextStyler()
  .fontFamily('Roboto')
  .fontSize(20)
  .fontWeight(FontWeight.w600)
  .color(Colors.red)
  .backgroundColor(Colors.yellow.shade100)
  .shadows([
    ShadowMix(
      color: Colors.black26,
      offset: Offset(1, 1),
      blurRadius: 2,
    ),
  ])
  .letterSpacing(1.2)
  .wordSpacing(2.0)
  .decoration(TextDecoration.underline)
  .decorationStyle(TextDecorationStyle.wavy)
  .titleCase();

// Minimalist text styling
final simpleText = TextStyler()
  .fontSize(14)
  .color(Colors.black87)
  .height(1.5);
```

--------------------------------

TITLE: Loading and Error State Overlays
DESCRIPTION: Demonstrates stack configurations for displaying loading indicators and error messages. These examples utilize background colors and padding to create distinct overlay states.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_util_api.md#_snippet_24

LANGUAGE: dart
CODE:
```
// Loading overlay
final loadingOverlay = $stack
  .alignment.center()
  .fit.expand()
  .wrap.backgroundColor(Colors.white.withOpacity(0.8));

// Error state overlay
final errorOverlay = $stack
  .alignment.center()
  .fit.loose()
  .wrap.padding(EdgeInsets.all(32));
```

--------------------------------

TITLE: Fumadocs Next.js Configuration for Vercel
DESCRIPTION: Configure the `next.config.mjs` file for optimal deployment on Vercel, including MDX support and redirect handling.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_3

LANGUAGE: javascript
CODE:
```
import { createMDX } from 'fumadocs-mdx/next';

const withMDX = createMDX();

/** @type {import('next').NextConfig} */
const config = {
  // No output: 'export' needed for Vercel
  // No basePath needed for Vercel custom domains
  reactStrictMode: true,

  // Preserve existing redirects from Mix website
  async redirects() {
    return [
      {
        source: "/docs/changelog",
        destination: "https://github.com/btwld/mix/releases",
        permanent: true,
      },
    ];
  },
};

export default withMDX(config);
```

--------------------------------

TITLE: Card Layouts with Clipping and Overlays
DESCRIPTION: Provides examples for creating distinct card layouts, such as product cards with overlays and profile cards with avatar elements. It showcases the use of `clipBehavior` and wrapping for visual customization.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_util_api.md#_snippet_20

LANGUAGE: dart
CODE:
```
// Product card with overlay information
final productCard = $stack
  .alignment.bottomLeft()
  .fit.expand()
  .clipBehavior.hardEdge()
  .wrap.borderRadius(BorderRadius.circular(12));

// Profile card with avatar overlay
final profileCard = $stack
  .alignment.topCenter()
  .fit.loose()
  .clipBehavior.none();
```

--------------------------------

TITLE: Organizing Theme Data
DESCRIPTION: Shows how to organize theme data into maps, separating definitions for light and dark themes, spacing, and typography. This structure facilitates easy management and application of theme variations.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_21

LANGUAGE: dart
CODE:
```
class AppTheme {
  static Map<ColorToken, Color> get lightColors => {
    AppTokens.primary: Colors.blue,
    AppTokens.secondary: Colors.blue.shade100,
    AppTokens.surface: Colors.white,
  };
  
  static Map<ColorToken, Color> get darkColors => {
    AppTokens.primary: Colors.blue.shade300,
    AppTokens.secondary: Colors.blue.shade800,
    AppTokens.surface: Colors.grey.shade900,
  };
  
  static Map<SpaceToken, double> get spacing => {
    AppTokens.xs: 4.0,
    AppTokens.sm: 8.0,
    AppTokens.md: 16.0,
    AppTokens.lg: 24.0,
    AppTokens.xl: 32.0,
  };
  
  static Map<TextStyleToken, TextStyle> get typography => {
    AppTokens.heading1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    AppTokens.heading2: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    AppTokens.body: TextStyle(fontSize: 16),
    AppTokens.caption: TextStyle(fontSize: 12, color: Colors.grey),
  };
}
```

--------------------------------

TITLE: Mix Dot Notation vs. Cascade Syntax (Dart)
DESCRIPTION: Compares the traditional cascade notation with Mix's new dot notation syntax for styling Flutter widgets. Dot notation offers cleaner, more readable code and better IDE support.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/example/README.md#_snippet_0

LANGUAGE: dart
CODE:
```
final style = Style(
  $box.height(100)
    ..width(100)
    ..color.blue()
    ..borderRadius(10),
);

final style = Style.box(
  .color(Colors.blue)
  .height(100)
  .width(100)
  .borderRadius(.circular(10))
  .onHovered(.scale(1.5))
);
```

--------------------------------

TITLE: Using Design Tokens for Theming in Mix
DESCRIPTION: Illustrates the usage of design tokens for theming in Mix. It defines a primary color token and applies it to the box color and border-radius.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/example/README.md#_snippet_7

LANGUAGE: dart
CODE:
```
final $primaryColor = MixToken<Color>('primary');

final style = Style.box(
  .color($primaryColor())
  .borderRadius(.topLeft($pill()))
);

MixScope(
  tokens: {$primaryColor: Colors.blue},
  child: Box(style: style),
);
```

--------------------------------

TITLE: Composed Styling Example
DESCRIPTION: Demonstrates how to create complex, multi-property styles by chaining various utility methods, such as color, padding, margin, border-radius, and shadow.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/spec_util_api.md#_snippet_21

LANGUAGE: dart
CODE:
```
// Complex, multi-property styling
final fancyCard = $box
  .color.white()
  .padding.all(20)
  .margin.horizontal(16).margin.vertical(8)
  .borderRadius.circular(12)
  .shadow.large()
  .border.all(color: Colors.grey.shade200);
```

--------------------------------

TITLE: Using Tokens in Styles with .token()
DESCRIPTION: Demonstrates the standard pattern for applying theme tokens to widget styles using the `.token()` method. This allows for dynamic and consistent styling across the application.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_14

LANGUAGE: dart
CODE:
```
// Using .token() method (current standard)
final style = Style(
  $box.color.token(primaryColor),
  $box.padding.all.token(largeSpace),
  $text.style.token(headingStyle),
);
```

--------------------------------

TITLE: Using Tokens Directly for Styling Refs
DESCRIPTION: Shows how to use tokens directly by calling them, which returns references (Refs) that can then be used in styling utilities. This provides a more granular control over token application.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_15

LANGUAGE: dart
CODE:
```
// Token call() method returns refs for styling
final colorRef = primaryColor(); // Returns ColorRef
final spaceRef = largeSpace();   // Returns SpaceRef
final styleRef = headingStyle(); // Returns TextStyleRef

// Use refs in styling utilities
final style = Style(
  $box.color(colorRef),
  $box.padding.all(spaceRef),
  $text.style(styleRef),
);
```

--------------------------------

TITLE: Box: Fixed Square Size
DESCRIPTION: Demonstrates creating a BoxMix with a fixed square size using fluent chaining or a constructor with BoxConstraintsMix.

SOURCE: https://github.com/btwld/mix/blob/main/guides/api-composition-guidelines.md#_snippet_0

LANGUAGE: dart
CODE:
```
final box = BoxMix().size(200, 200);
final boxAlt = BoxMix(constraints: BoxConstraintsMix.square(200));
```

--------------------------------

TITLE: Hero Image with Tint Example
DESCRIPTION: Demonstrates styling for a hero image, utilizing full width, a fixed height, cover fit, and a color overlay with a darken blend mode.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_70

LANGUAGE: dart
CODE:
```
final heroImage = $image
  .width(double.infinity)
  .height(250)
  .fit.cover()
  .alignment.center()
  .color.black().withOpacity(0.2)
  .colorBlendMode.darken();
```

--------------------------------

TITLE: Layout Combinations Example
DESCRIPTION: Illustrates combining layout utilities like `flexbox` with visual styling properties to create sophisticated UI layouts, such as navigation bars with specific alignment and spacing.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/spec_util_api.md#_snippet_23

LANGUAGE: dart
CODE:
```
// Combining layout and visual styling
final navBar = $flexbox
  .color.blue().shade800()
  .padding.horizontal(24).padding.vertical(12)
  .direction.horizontal()
  .mainAxisAlignment.spaceBetween()
  .crossAxisAlignment.center();
```

--------------------------------

TITLE: Update Source Configuration for Multi-Version Docs (TypeScript)
DESCRIPTION: Configures the documentation source using `fumadocs-core/source` to handle multiple versions by referencing the `docs` and `meta` objects.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_13

LANGUAGE: typescript
CODE:
```
import { docs, meta } from '@/.source';
import { createMDXSource } from 'fumadocs-mdx';
import { loader } from 'fumadocs-core/source';

export const source = loader({
  baseUrl: '/docs',
  source: createMDXSource(docs, meta),
});

// Export page tree for layouts
export const pageTree = source.pageTree;
```

--------------------------------

TITLE: Box: Fixed Width and Height
DESCRIPTION: Shows how to set a specific width and height for a BoxMix using chained method calls.

SOURCE: https://github.com/btwld/mix/blob/main/guides/api-composition-guidelines.md#_snippet_1

LANGUAGE: dart
CODE:
```
final box = BoxMix().width(200).height(120);
```

--------------------------------

TITLE: Style Box Border Directional Start Side
DESCRIPTION: Applies styles specifically to the start side of BorderDirectional for a Box.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/utilities/box-utilities.md#_snippet_34

LANGUAGE: dart
CODE:
```
$box.borderDirectional.start.color.red();
$box.borderDirectional.start.width(2);
$box.borderDirectional.start.style.solid();
$box.borderDirectional.start.strokeAlign(0.5);
```

--------------------------------

TITLE: Defining App Token Constants
DESCRIPTION: Demonstrates best practices for defining token constants within a class, categorizing them by type (Colors, Spacing, Typography, Radius, Shadows) for better organization and reusability.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_20

LANGUAGE: dart
CODE:
```
class AppTokens {
  // Colors
  static const primary = ColorToken('primary');
  static const secondary = ColorToken('secondary');
  static const surface = ColorToken('surface');
  
  // Spacing
  static const xs = SpaceToken('xs');
  static const sm = SpaceToken('sm');
  static const md = SpaceToken('md');
  static const lg = SpaceToken('lg');
  static const xl = SpaceToken('xl');
  
  // Typography
  static const heading1 = TextStyleToken('heading1');
  static const heading2 = TextStyleToken('heading2');
  static const body = TextStyleToken('body');
  static const caption = TextStyleToken('caption');
  
  // Radius
  static const rounded = RadiusToken('rounded');
  static const circular = RadiusToken('circular');
  
  // Shadows
  static const cardShadow = BoxShadowToken('card.shadow');
  static const textShadow = ShadowToken('text.shadow');
}
```

--------------------------------

TITLE: Update Source Configuration (Fumadocs)
DESCRIPTION: Configures the documentation source directory and base URL for Fumadocs. It uses `defineDocs` from `fumadocs-mdx/config` to set up the documentation structure.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_4

LANGUAGE: typescript
CODE:
```
import { defineDocs, defineConfig } from 'fumadocs-mdx/config';

export const { docs, meta } = defineDocs({
  docs: {
    dir: './content/docs',
    baseUrl: '/docs',
  },
});

export default defineConfig();
```

--------------------------------

TITLE: Set Box Border on Start Side
DESCRIPTION: Applies border properties to the start side of the box (dependent on directionality). Properties include color, width, style, and stroke alignment.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/utilities/box-utilities.md#_snippet_25

LANGUAGE: dart
CODE:
```
$box.border.start.color.red();
$box.border.start.width(2);
$box.border.start.style.solid();
$box.border.start.strokeAlign(0.5);
```

--------------------------------

TITLE: Debug Tips for Tokens (Dart)
DESCRIPTION: Provides code snippets for debugging token-related issues. It includes checking if a token exists in the `MixScope` and retrieving its value for inspection.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_32

LANGUAGE: dart
CODE:
```
// Check if token exists in scope
final scope = MixScope.of(context);
final hasToken = scope.tokens?.containsKey(myToken) ?? false;

// Get token value for debugging
final tokenValue = scope.getToken(myToken, context);
```

--------------------------------

TITLE: Building Styles with BoxStyler
DESCRIPTION: Demonstrates building a BoxStyler with chained methods for width, padding, alignment, and color using the builder design pattern.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/utility-first.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
final boxStyle = BoxStyler()
  .width(100)
  .paddingAll(10)
  .alignment(Alignment.center)
  .color(Colors.red);
```

--------------------------------

TITLE: Advanced Image Styling Example
DESCRIPTION: Shows advanced image styling with multiple modifiers including alignment, color effects, filter quality, anti-aliasing, and animation.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_68

LANGUAGE: dart
CODE:
```
final styledImage = $image
  .width(300)
  .height(200)
  .fit.cover()
  .alignment.center()
  .color.blue().withOpacity(0.3)
  .colorBlendMode(BlendMode.overlay)
  .filterQuality.high()
  .isAntiAlias(true)
  .animate(AnimationConfig(duration: Duration(milliseconds: 500)));
```

--------------------------------

TITLE: Update Project Dependencies
DESCRIPTION: Commands to update the project's Node.js dependencies using npm. It's recommended to run these regularly.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_19

LANGUAGE: bash
CODE:
```
cd docs
npm update
```

--------------------------------

TITLE: Basic Styled Flex Container Example
DESCRIPTION: Demonstrates how to create a basic styled flex container using the global utility `$flexbox`. It sets color, padding, border radius, direction, and alignment properties.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flexbox/flexbox_style_api.md#_snippet_27

LANGUAGE: dart
CODE:
```
final styledContainer = $flexbox
  .color.blue().shade100()
  .padding.all(16)
  .borderRadius(8)
  .direction(Axis.horizontal)
  .mainAxisAlignment.spaceBetween()
  .crossAxisAlignment.center()
  .spacing(12);
```

--------------------------------

TITLE: Using BoxShadowToken with List Values
DESCRIPTION: Demonstrates the correct way to define BoxShadowToken with a list of BoxShadow values, replacing single-value definitions for predictable merging.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_33

LANGUAGE: dart
CODE:
```
// Old (single value)
// BoxShadowToken('shadow.card'): const BoxShadow(...)

// New (list-based)
BoxShadowToken('shadow.card'): const [
  BoxShadow(blurRadius: 8, offset: Offset(0, 4))
]
```

--------------------------------

TITLE: Animation with Hover Effects in Mix
DESCRIPTION: Shows how to apply animations and hover effects using Mix. It changes the color and scale of an element on hover and applies an easing animation.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/example/README.md#_snippet_6

LANGUAGE: dart
CODE:
```
final style = Style.box(
  .color(Colors.black)
  .onHovered(.color(Colors.blue).scale(1.5))
  .animate(.easeInOut(300.ms))
);
```

--------------------------------

TITLE: Update Internal Links (Markdown)
DESCRIPTION: Illustrates the change required for internal links when migrating from Nextra's flat structure to Fumadocs' versioned structure.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_9

LANGUAGE: markdown
CODE:
```
Before (Nextra):
[Getting Started](/docs/overview/getting-started)

After (Fumadocs):
[Getting Started](/docs/v1/overview/getting-started)
```

--------------------------------

TITLE: Material Design Theme Integration with MixScope
DESCRIPTION: Integrates MixScope with Material Design by using MixScope.withMaterial, allowing for the addition of custom theme colors that supplement the default Material Design theme.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_13

LANGUAGE: dart
CODE:
```
void main() {
  runApp(
    MixScope.withMaterial(
      colors: {
        // Your custom colors in addition to Material colors
        primaryColor: Colors.purple,
      },
      child: MyApp(),
    ),
  );
}
```

--------------------------------

TITLE: Light/Dark Theme Support (Dart)
DESCRIPTION: Demonstrates how to implement light and dark theme support in a Flutter application using `MixScope`. It dynamically sets the `colors`, `spaces`, and `textStyles` based on the platform's brightness.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_26

LANGUAGE: dart
CODE:
```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isLight = brightness == Brightness.light;
    
    return MixScope(
      colors: isLight ? AppTheme.lightColors : AppTheme.darkColors,
      spaces: AppTheme.spacing,
      textStyles: AppTheme.typography,
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
```

--------------------------------

TITLE: Box Widget Usage
DESCRIPTION: Demonstrates the basic usage of the Box widget with styling.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/box.mdx#_snippet_1

LANGUAGE: APIDOC
CODE:
```
## Box Widget

### Description
This widget is equivalent to the `Container` widget in Flutter, allowing for styling and layout.

### Method
N/A (This is a widget, not an API endpoint)

### Endpoint
N/A

### Parameters
#### Constructor Parameters
- **child** (Widget?) - Optional - The widget to display inside the Box.
- **style** (Style<BoxSpec>?) - Optional, defaults to `BoxStyler.create()` - The styling configuration for the Box.
- **key** (Key?) - Optional - A unique identifier for the widget.

### Style API Reference
This section details the methods available on `BoxStyler` for customizing the Box widget's appearance and behavior.

**Common Styling Methods:**
- `width(double value)`: Sets the fixed width of the box.
- `height(double value)`: Sets the fixed height of the box.
- `color(Color value)`: Sets the background color of the box.
- `borderRounded(double value)`: Applies a uniform border radius to all corners.
- `padding(EdgeInsets value)`: Sets padding for all sides of the box.
- `margin(EdgeInsets value)`: Sets margin for all sides of the box.

**Detailed Styling Methods:**
- `animate()`: Sets animation configuration.
- `modifier()`: Adds widget modifiers.
- `alignment()`: Sets box alignment.
- `transformAlignment()`: Sets transform alignment.
- `clipBehavior()`: Sets clip behavior.
- `paddingTop()`, `paddingBottom()`, `paddingLeft()`, `paddingRight()`: Set specific padding values.
- `paddingX()`, `paddingY()`: Set horizontal and vertical padding.
- `paddingAll()`: Sets padding on all sides.
- `paddingStart()`, `paddingEnd()`: Set start and end padding (RTL-aware).
- `paddingOnly()`: Sets specific padding values.
- `marginTop()`, `marginBottom()`, `marginLeft()`, `marginRight()`: Set specific margin values.
- `marginX()`, `marginY()`: Set horizontal and vertical margins.
- `marginAll()`: Sets margin on all sides.
- `marginStart()`, `marginEnd()`: Set start and end margins (RTL-aware).
- `marginOnly()`: Sets specific margin values.
- `gradient()`: Sets gradient background.
- `shadow()`: Sets single shadow.
- `shadows()`: Sets multiple shadows.
- `elevation()`: Sets Material elevation.
- `image()`: Sets background image.
- `shape()`: Sets shape.
- `border()`: Sets border.
- `borderRadius()`: Sets border radius.
- `borderTop()`, `borderBottom()`, `borderLeft()`, `borderRight()`: Set specific border values.
- `borderStart()`, `borderEnd()`: Set start and end borders (RTL-aware).
- `borderVertical()`: Sets top and bottom borders.
- `borderHorizontal()`: Sets left and right borders.
- `borderAll()`: Sets all borders.
- `borderRadiusAll()`: Sets radius on all corners.
- `borderRadiusTop()`, `borderRadiusBottom()`, `borderRadiusLeft()`, `borderRadiusRight()`: Set radius on specific corners.
- `borderRadiusTopLeft()`, `borderRadiusTopRight()`, `borderRadiusBottomLeft()`, `borderRadiusBottomRight()`: Set radius on specific corners.
- `borderRadiusTopStart()`, `borderRadiusTopEnd()`, `borderRadiusBottomStart()`, `borderRadiusBottomEnd()`: Set radius on specific corners (RTL-aware).
- `borderRoundedTop()`, `borderRoundedBottom()`, `borderRoundedLeft()`, `borderRoundedRight()`: Set circular radius on specific corners.
- `borderRoundedTopLeft()`, `borderRoundedTopRight()`, `borderRoundedBottomLeft()`, `borderRoundedBottomRight()`: Set circular radius on specific corners.
- `borderRoundedTopStart()`, `borderRoundedTopEnd()`, `borderRoundedBottomStart()`, `borderRoundedBottomEnd()`: Set circular radius on specific corners (RTL-aware).
- `shadowOnly()`: Creates single shadow with parameters.
- `boxShadows()`: Sets multiple box shadows.
- `boxElevation()`: Sets Material elevation shadow.
- `rotate()`: Sets rotation transform.
- `scale()`: Sets scale transform.
- `translate()`: Sets translation transform.
- `skew()`: Sets skew transform.
- `transformReset()`: Resets transform to identity.

### Request Example
```dart
Box(
  style: BoxStyler()
      .width(100)
      .height(100)
      .color(Colors.blue)
      .borderRounded(8),
  child: Text('Styled Box'),
);
```

### Response
N/A (This is a client-side widget rendering example)

```

--------------------------------

TITLE: Button Container Example
DESCRIPTION: Illustrates creating a button-like container using the global utility `$flexbox`. It styles the color, border radius, padding, direction, main and cross-axis alignment, and spacing.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flexbox/flexbox_style_api.md#_snippet_29

LANGUAGE: dart
CODE:
```
final buttonContainer = $flexbox
  .color.blue()
  .borderRadius(8)
  .padding.symmetric(horizontal: 24, vertical: 12)
  .direction(Axis.horizontal)
  .mainAxisAlignment.center()
  .crossAxisAlignment.center()
  .spacing(8);
```

--------------------------------

TITLE: Update Usage (Dart)
DESCRIPTION: Confirms that the usage pattern for applying tokens to styles remains consistent after migration. The `$box.color.token()` and `$box.padding.all.token()` syntax is still the standard way to reference tokens.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_31

LANGUAGE: dart
CODE:
```
// Usage remains the same
$box.color.token(primaryColor)
$box.padding.all.token(largeSpace)
```

--------------------------------

TITLE: Apply Variant Styles with Style
DESCRIPTION: Demonstrates how to apply specific styles to button variants within a Mix Style. This example shows styling for the 'filled' variant.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/creating-a-widget.md#_snippet_5

LANGUAGE: dart
CODE:
```
final style = Style(
  ButtonVariant.filled(
    // styles for filled variant
  ),
);
```

--------------------------------

TITLE: Testing Composed Fragment Properties
DESCRIPTION: Shows how to assert the resolved properties of a composed Mix instance created using `merge()`.

SOURCE: https://github.com/btwld/mix/blob/main/guides/api-composition-guidelines.md#_snippet_8

LANGUAGE: dart
CODE:
```
final base = BoxMix().padding(EdgeInsetsMix.all(16));
final elevated = BoxMix().borderRadius(BorderRadiusMix.circular(12));
final card = base.merge(elevated);

// Assert the resolved properties from the merged Mix
expect(card.$padding, resolvesTo(const EdgeInsets.all(16), context: context));
```

--------------------------------

TITLE: TextStyleToken Implementation in Dart
DESCRIPTION: A concrete implementation of MixToken for TextStyle values. It overrides the call() method to return a TextStyleRef, which is a token reference for TextStyles.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_4

LANGUAGE: dart
CODE:
```
class TextStyleToken extends MixToken<TextStyle> {
  const TextStyleToken(super.name);
  
  @override
  TextStyleRef call() => TextStyleRef(Prop.token(this));
}
```

--------------------------------

TITLE: Stack Alignment Utilities
DESCRIPTION: Provides examples of using stack alignment utilities to position layers within the ZBox. These methods influence how children are aligned within the stacking context.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/stack.mdx#_snippet_1

LANGUAGE: dart
CODE:
```
// Align at the bottom center of the stack
$stack.alignment.bottomCenter();
```

LANGUAGE: dart
CODE:
```
// Align at the top right of the stack
$stack.alignment.topRight();
```

--------------------------------

TITLE: Disabled Pressable Example
DESCRIPTION: Illustrates how to disable a Pressable widget, preventing its press event from being triggered.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/pressable.mdx#_snippet_2

LANGUAGE: dart
CODE:
```
Pressable(
  enabled: false,
  onPress: () => print('This won\'t be called'),
  child: StyledText('Disabled Button'),
);
```

--------------------------------

TITLE: Provide Tokens at App Root in Dart
DESCRIPTION: Demonstrates how to wrap the application's root widget with `MixScope` to provide color and space tokens globally. This makes the defined tokens accessible throughout the widget tree.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_9

LANGUAGE: dart
CODE:
```
void main() {
  runApp(
    MixScope(
      colors: { $brandPrimary: Colors.blue },
      spaces: { $contentPadding: 20.0 },
      child: const MyApp(),
    ),
  );
}
```

--------------------------------

TITLE: Creating Custom Styler Helpers
DESCRIPTION: Demonstrates creating custom shorthand for BoxStyler styling using helper functions and extension methods.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/utility-first.mdx#_snippet_3

LANGUAGE: dart
CODE:
```
// Custom helper for border top styling
BoxStyler borderTop(Color color) => BoxStyler().borderTop(color: color);

// Use the helper
borderTop(Colors.red);

// Extension method
extension on BoxStyler {
  BoxStyler borderRedTop() => borderTop(color: Colors.red);
}

// Use the extension method
BoxStyler().borderRedTop();
```

--------------------------------

TITLE: Set Box BorderRadius Top Start
DESCRIPTION: Applies BorderRadiusDirectional to the top-start corner of a Box using different radius types.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/utilities/box-utilities.md#_snippet_44

LANGUAGE: dart
CODE:
```
$box.borderRadius.topStart(10);
$box.borderRadius.topStart.circular(10);
$box.borderRadius.topStart.elliptical(10, 20);
$box.borderRadius.topStart.zero();
```

--------------------------------

TITLE: ColorToken Implementation in Dart
DESCRIPTION: A concrete implementation of MixToken for Color values. It overrides the call() method to return a ColorRef, which is a token reference for colors.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_1

LANGUAGE: dart
CODE:
```
class ColorToken extends MixToken<Color> {
  const ColorToken(super.name);
  
  @override
  ColorRef call() => ColorRef(Prop.token(this));
}
```

--------------------------------

TITLE: Avoid Inline Styles in Widgets (Dart)
DESCRIPTION: Demonstrates the recommended approach of defining styles separately and applying them to widgets, contrasting with the discouraged practice of using inline styles.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/ai.txt#_snippet_3

LANGUAGE: dart
CODE:
```
Box(
    style: Style(
        $box.height(100)
        $box.width(100)
        $box.color.red()
    )
)

final style = Style(
    $box.height(100)
    $box.width(100)
    $box.color.red()
);

Box(
    style: style,
)
```

--------------------------------

TITLE: Define Type-Safe Tokens (Dart)
DESCRIPTION: Demonstrates creating type-safe tokens for colors and text styles using `ColorToken` and `TextStyleToken`. It also shows how to consistently apply these tokens using the '$' syntax.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_22

LANGUAGE: dart
CODE:
```
// Good: Type-safe token creation
const primaryColor = ColorToken('primary');

// Good: Clear naming convention
const headerTextStyle = TextStyleToken('text.header');

// Good: Consistent usage
$box.color.token(primaryColor)
$text.style.token(headerTextStyle)
```

--------------------------------

TITLE: Test ModifierAttribute Properties and Merging
DESCRIPTION: Shows how to test the properties of `ModifierAttribute` and how the replacement merge strategy for `Prop<T>` applies when merging attributes.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/test/helpers/testing_guide.md#_snippet_3

LANGUAGE: dart
CODE:
```
test('modifier attribute properties are set correctly', () {
  final attribute = OpacityModifierAttribute(opacity: Prop.value(0.5));

  expect(attribute.opacity, resolvesTo(0.5));
});

test('modifier attribute merging uses replacement strategy', () {
  final attr1 = AspectRatioModifierAttribute(aspectRatio: Prop.value(1.0));
  final attr2 = AspectRatioModifierAttribute(aspectRatio: Prop.value(2.0));

  final merged = attr1.merge(attr2);

  // Prop<T> uses replacement
  expect(merged.aspectRatio, resolvesTo(2.0));
});

test('modifier attribute resolves to modifier', () {
  final attribute = OpacityModifierAttribute(opacity: Prop.value(0.8));

  expect(attribute, resolvesTo(const OpacityModifier(0.8)));
});
```

--------------------------------

TITLE: StackSpecUtility: Basic Stack Layouts
DESCRIPTION: Demonstrates creating basic stack layouts with centered and expanded configurations using the StackSpecUtility. It showcases setting alignment, fit, and clip behavior.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_util_api.md#_snippet_0

LANGUAGE: dart
CODE:
```
final centeredStack = $stack
  .alignment.center()
  .fit.loose();

final expandedStack = $stack
  .alignment.topLeft()
  .fit.expand()
  .clipBehavior.hardEdge();
```

--------------------------------

TITLE: Using Tokens in Properties
DESCRIPTION: Illustrates how to utilize theme tokens when defining properties, such as `SpaceDto` and `Prop<T>`, enabling the use of theme-defined values directly in property assignments.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_16

LANGUAGE: dart
CODE:
```
// SpaceDto with tokens
final spacing = SpaceDto.token(largeSpace);

// Prop<T> with tokens  
final colorProp = Prop.token(primaryColor);
```

--------------------------------

TITLE: BreakpointToken Implementation in Dart
DESCRIPTION: A concrete implementation of MixToken for Breakpoint values. It overrides the call() method to return a BreakpointRef, which is a token reference for Breakpoints.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_5

LANGUAGE: dart
CODE:
```
class BreakpointToken extends MixToken<Breakpoint> {
  const BreakpointToken(super.name);
  
  @override
  BreakpointRef call() => BreakpointRef(Prop.token(this));
}
```

--------------------------------

TITLE: Required Frontmatter for MDX Files
DESCRIPTION: Specifies the essential frontmatter fields required for all MDX documentation files, such as title and an optional description.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_11

LANGUAGE: mdx
CODE:
```
---
title: Page Title
description: Optional page description
---

# Page Content
```

--------------------------------

TITLE: Style Box Border Directional Horizontal Sides
DESCRIPTION: Applies styles to the horizontal (start and end) sides of BorderDirectional for a Box.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/utilities/box-utilities.md#_snippet_36

LANGUAGE: dart
CODE:
```
$box.borderDirectional.horizontal.color.red();
$box.borderDirectional.horizontal.width(2);
$box.borderDirectional.horizontal.style.solid();
$box.borderDirectional.horizontal.strokeAlign(0.5);
```

--------------------------------

TITLE: Apply Widget Modifiers
DESCRIPTION: Wraps the icon with various widget modifiers to alter its presentation or behavior. Examples include applying opacity, padding, or transformations.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_util_api.md#_snippet_16

LANGUAGE: dart
CODE:
```
$icon.wrap.opacity(0.75)
$icon.wrap.padding(EdgeInsets.all(8.0))
```

--------------------------------

TITLE: StackSpecUtility: Alignment Methods
DESCRIPTION: Provides examples of setting various child alignment options for a stack using the `$stack.alignment` property. This includes aligning children to corners, centers, and edges.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_util_api.md#_snippet_2

LANGUAGE: dart
CODE:
```
// Align children to top-left
$stack.alignment.topLeft();

// Center children in the stack
$stack.alignment.center();

// Align children to bottom-right
$stack.alignment.bottomRight();
```

--------------------------------

TITLE: Leveraging Design Tokens for Buttons and Typography in Mix
DESCRIPTION: Shows how to define design tokens for buttons (primary and secondary) and typography (h1, h2, body, caption) using Mix's Style utility, including hover and press states.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/ai.txt#_snippet_2

LANGUAGE: dart
CODE:
```
// Button styles
final primaryButton = Style(
  $box.padding(12, 24),
  $box.color.blue(),
  $box.borderRadius(8),
  $text.style.color.white(),
  $text.style.fontWeight.w600(),
  $on.hover($box.color.blue(700)),
  $on.press($box.color.blue(900)),
);

final secondaryButton = Style(
  $box.padding(12, 24),
  $box.borderRadius(8),
  $box.border.all.color.blue(),
  $box.border.all.width(2),
  $text.style.color.blue(),
  $text.style.fontWeight.w600(),
  $on.hover($box.color.blue(50)),
);

// Typography
final h1 = Style(
  $text.style.fontSize(32),
  $text.style.fontWeight.bold(),
);

final h2 = Style(
  $text.style.fontSize(24),
  $text.style.fontWeight.w600(),
);

final body = Style(
  $text.style.fontSize(16),
  $text.style.height(1.5),
);

final caption = Style(
  $text.style.fontSize(14),
  $text.style.color.gray(600),
);
```

--------------------------------

TITLE: Common Stack Patterns and Layouts
DESCRIPTION: Provides examples of common UI patterns implemented using stack styling, including overlays, backgrounds, floating action buttons, loading indicators, badges, and cards with images.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_style_api.md#_snippet_24

LANGUAGE: dart
CODE:
```
// Overlay pattern
final overlayStack = $stack
  .alignment.center()
  .fit.expand();

// Background with content
final backgroundStack = $stack
  .alignment.topLeft()
  .fit.expand();

// Floating action button pattern
final fabStack = $stack
  .alignment.bottomRight()
  .fit.loose();

// Loading overlay
final loadingStack = $stack
  .alignment.center()
  .fit.expand()
  .clipBehavior.hardEdge();

// Badge/notification pattern
final badgeStack = $stack
  .alignment.topRight()
  .fit.loose();

// Card with header image
final cardStack = $stack
  .alignment.topLeft()
  .fit.expand()
  .clipBehavior.antiAlias();
```

--------------------------------

TITLE: Frontmatter Structure for MDX Files
DESCRIPTION: This snippet shows the required frontmatter structure for all MDX files to ensure proper metadata handling in Fumadocs.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_18

LANGUAGE: mdx
CODE:
```
---
title: Page Title
description: Brief description
---
```

--------------------------------

TITLE: Dart: Common Text Styling Patterns
DESCRIPTION: Provides examples of common text styling patterns using a shorthand `$text` syntax. Covers styles for buttons, titles, body text, error messages, and links, demonstrating concise application of font properties and decorations.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_64

LANGUAGE: dart
CODE:
```
// Button text
final buttonText = $text
  .fontSize(16)
  .fontWeight.w600()
  .color.white()
  .letterSpacing(0.5);

// Title text
final titleText = $text
  .fontSize(24)
  .fontWeight.bold()
  .color.black87()
  .height(1.2);

// Body text with custom styling
final bodyText = $text
  .fontSize(14)
  .color.grey.shade800()
  .height(1.5)
  .fontFamily('Inter')
  .letterSpacing(0.1);

// Error text
final errorText = $text
  .fontSize(12)
  .color.red()
  .fontWeight.w500();

// Link text
final linkText = $text
  .color.blue()
  .decoration(TextDecoration.underline)
  .decorationColor.blue();
```

--------------------------------

TITLE: ShadowToken Implementation in Dart
DESCRIPTION: A concrete implementation of MixToken for Shadow values. It overrides the call() method to return a ShadowRef, which is a token reference for Shadow objects.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_7

LANGUAGE: dart
CODE:
```
class ShadowToken extends MixToken<Shadow> {
  const ShadowToken(super.name);
  
  @override
  ShadowRef call() => ShadowRef(Prop.token(this));
}
```

--------------------------------

TITLE: Limit Style Complexity: Break Down Large Styles (Dart)
DESCRIPTION: Illustrates how to manage complex styles by breaking them into smaller, reusable style definitions and then combining them, promoting modularity and readability.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/ai.txt#_snippet_4

LANGUAGE: dart
CODE:
```
final complexStyle = Style(
  $box.padding(16),
  $box.borderRadius(12),
  $box.color.white(),
  $box.elevation(2),
  $on.hover($box.elevation(4)),
  $text.style.fontSize(20),
  $text.style.fontWeight.bold(),
  $text.style.color.green(600),
  $text.style.fontSize(16),
  $text.style.fontWeight.w500(),
);

final itemCardStyle = Style(
  $box.padding(16),
  $box.borderRadius(12),
  $box.color.white(),
  $box.elevation(2),
  $on.hover($box.elevation(4)),
);

final priceTextStyle = Style(
  $text.style.fontSize(20),
  $text.style.fontWeight.bold(),
  $text.style.color.green(600),
);

final titleTextStyle = Style(
  $text.style.fontSize(16),
  $text.style.fontWeight.w500(),
);

final combinedStyle = Style(
    itemCardStyle,
    priceTextStyle,
    titleTextStyle,
)
```

--------------------------------

TITLE: Add Mix Lint and Custom Lint Dependencies
DESCRIPTION: Installs the mix_lint and custom_lint packages as development dependencies in your Flutter project.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix_lint/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
flutter pub add -d mix_lint custom_lint
```

--------------------------------

TITLE: Flutter Button Demo with MixTheme
DESCRIPTION: Shows a main application entry point and a StatelessWidget that builds a UI with different button types using the MixTheme. It imports necessary Flutter material and mix packages.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/creating-a-widget.md#_snippet_20

LANGUAGE: dart
CODE:
```
// Main App
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final icon = Icons.favorite;

    return MaterialApp(
      home: MixTheme(
        data: MixThemeData.withMaterial(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  label: 'Button',
                  icon: icon,
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                OutlinedButton(
                  label: 'Button',
                  icon: icon,
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  label: 'Button',
                  icon: icon,
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                LinkButton(
                  label: 'Button',
                  icon: icon,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

--------------------------------

TITLE: BoxShadowToken Implementation in Dart
DESCRIPTION: A concrete implementation of MixToken for BoxShadow values. It overrides the call() method to return a BoxShadowRef, which is a token reference for BoxShadow objects.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_6

LANGUAGE: dart
CODE:
```
class BoxShadowToken extends MixToken<BoxShadow> {
  const BoxShadowToken(super.name);
  
  @override
  BoxShadowRef call() => BoxShadowRef(Prop.token(this));
}
```

--------------------------------

TITLE: Update Imports (Dart)
DESCRIPTION: Shows the change in import statements required for migration. Previously, specific token files were imported; now, all tokens are available through the consolidated `package:mix/mix.dart` public API.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_30

LANGUAGE: dart
CODE:
```
// Old imports (remove these)
import 'package:mix/src/theme/tokens/color_token.dart';
import 'package:mix/src/theme/tokens/space_token.dart';

// New import (consolidated)
import 'package:mix/mix.dart'; // All tokens available via public API
```

--------------------------------

TITLE: Navigation and UI Overlay Stacks
DESCRIPTION: Shows examples of stacks used for navigation elements like Floating Action Buttons (FABs), modal overlays, and drawer overlays. It covers positioning, background colors, and text direction adjustments.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_util_api.md#_snippet_22

LANGUAGE: dart
CODE:
```
// Floating action button overlay
final fabOverlay = $stack
  .alignment.bottomRight()
  .fit.loose()
  .wrap.padding(EdgeInsets.all(16));

// Modal overlay stack
final modalOverlay = $stack
  .alignment.center()
  .fit.expand()
  .wrap.backgroundColor(Colors.black54);

// Drawer overlay
final drawerOverlay = $stack
  .alignment.centerLeft()
  .fit.expand()
  .textDirection.ltr();
```

--------------------------------

TITLE: Extracting Repeated Styles in Mix
DESCRIPTION: Illustrates how to extract reusable style configurations as static fields within Dart classes using Mix's Style and conditional styling utilities like $on.hover.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/ai.txt#_snippet_1

LANGUAGE: dart
CODE:
```
static final aStyle = Style(
    $box
        ..padding(16),
        ..borderRadius(12),
        ..color.white(),
        ..elevation(2),
    $on.hover($box.elevation(4)),
);

static final bStyle = Style(
    $box.color.blue(),
)
```

--------------------------------

TITLE: BuildContext Responsive Styling in Flutter
DESCRIPTION: Illustrates how to create context-aware styles in Flutter using Mix. This example defines a style that changes its box color and text color based on whether the context is 'dark' or not.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/README.md#_snippet_2

LANGUAGE: dart
CODE:
```
final style = Style(
  $box.color.black(),
  $text.style.color.white(),
  $on.dark(
    $box.color.white(),
    $text.style.color.black(),
  ),
);
```

--------------------------------

TITLE: FlexBox Example in Dart
DESCRIPTION: Demonstrates the basic usage of FlexBox to create a horizontal layout with spaced-out children. It utilizes FlexBoxStyler for styling, setting the background color and main axis alignment.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/flexbox.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
FlexBox(
  style: FlexBoxStyler()
      .color(Colors.blue)
      .direction(Axis.horizontal)
      .mainAxisAlignment(MainAxisAlignment.spaceBetween),
  children: [
    Box(child: Text('Box 1')),
    Box(child: Text('Box 2')),
    Box(child: Text('Box 3')),
  ],
);
```

--------------------------------

TITLE: Icon Styling using IconStyler Constructor
DESCRIPTION: Shows how to instantiate and configure an IconStyler directly, applying properties like color, size, weight, fill, shadow, and animation.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_style_api.md#_snippet_55

LANGUAGE: dart
CODE:
```
final iconStyle = IconStyler()
  .color(Colors.blue)
  .size(24)
  .weight(400)
  .fill(0.5)
  .shadow(ShadowMix(
    color: Colors.black26,
    offset: Offset(2, 2),
    blurRadius: 4,
  ))
  .animate(AnimationConfig(duration: Duration(milliseconds: 300)));
```

--------------------------------

TITLE: RadiusToken Implementation in Dart
DESCRIPTION: A concrete implementation of MixToken for Radius values. It overrides the call() method to return a RadiusRef, which is a token reference for Radius objects.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_3

LANGUAGE: dart
CODE:
```
class RadiusToken extends MixToken<Radius> {
  const RadiusToken(super.name);
  
  @override
  RadiusRef call() => RadiusRef(Prop.token(this));
}
```

--------------------------------

TITLE: Using Tokens in Styles with BoxStyler
DESCRIPTION: Illustrates the typical usage of Mix tokens within styles, specifically using `BoxStyler`. It shows how to apply resolved token values like colors and spacing to widget properties.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_5

LANGUAGE: dart
CODE:
```
final $primary = ColorToken('brand.primary');
final $spacing = SpaceToken('space.md');
final $cardShadow = BoxShadowToken('shadow.card');

final style = BoxStyler()
  .color($primary())
  .padding(.all($spacing()));
  // For APIs that take lists of shadows/boxShadows
  // .boxShadow($cardShadow())
```

--------------------------------

TITLE: Common StackBox Patterns
DESCRIPTION: Presents a collection of common StackBoxStyler patterns for various UI elements. Examples include a hero section with overlay, a profile card with a badge, modal backdrops, notification badges, and images with gradient overlays, demonstrating versatile application of the styling.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_40

LANGUAGE: dart
CODE:
```
// Hero section with overlay
final heroSection = StackBoxStyler(
  decoration: DecorationMix.color(Colors.black),
  stackAlignment: Alignment.center,
  fit: StackFit.expand,
  clipBehavior: Clip.hardEdge,
);

// Profile card with badge
final profileCard = StackBoxStyler(
  decoration: DecorationMix(
    color: Colors.white,
    borderRadius: BorderRadiusGeometryMix.circular(12),
    border: BoxBorderMix.all(color: Colors.grey.shade200),
  ),
  padding: EdgeInsetsGeometryMix.all(16),
  stackAlignment: Alignment.topRight,
  fit: StackFit.loose,
);

// Modal backdrop
final modalBackdrop = StackBoxStyler(
  decoration: DecorationMix.color(Colors.black54),
  stackAlignment: Alignment.center,
  fit: StackFit.expand,
);

// Notification badge container
final badgeContainer = StackBoxStyler(
  stackAlignment: Alignment.topRight,
  fit: StackFit.loose,
  clipBehavior: Clip.none,
);

// Image with gradient overlay
final imageOverlay = StackBoxStyler(
  decoration: DecorationMix.gradient(
    GradientMix.linear(
      colors: [Colors.transparent, Colors.black54],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
  stackAlignment: Alignment.bottomLeft,
  fit: StackFit.expand,
  clipBehavior: Clip.antiAlias,
);
```

--------------------------------

TITLE: Test Prop Merging Behavior - Dart
DESCRIPTION: Demonstrates the merge behavior of Prop<T>, illustrating both replacement strategy for simple values and accumulation strategy for Mix values.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/test/helpers/testing_guide.md#_snippet_7

LANGUAGE: dart
CODE:
```
test('Prop<T> merge behavior - replacement strategy', () {
  final prop1 = Prop.value(100.0);
  final prop2 = Prop.value(200.0);
  final prop3 = Prop.value(300.0);

  final merged = prop1.mergeProp(prop2).mergeProp(prop3);

  // Test resolution (last value wins for regular values)
  expect(merged, resolvesTo(300.0));
});
```

LANGUAGE: dart
CODE:
```
test('Prop<V> with Mix values merge behavior - accumulation strategy', () {
  final borderMix1 = BorderMix(color: Prop.value(Colors.red), width: Prop.value(1.0));
  final borderMix2 = BorderMix(color: Prop.value(Colors.blue));
  final borderMix3 = BorderMix(style: Prop.value(BorderStyle.dashed));

  final prop1 = Prop.mix(borderMix1);
  final prop2 = Prop.mix(borderMix2);
  final prop3 = Prop.mix(borderMix3);

  final merged = prop1.mergeProp(prop2).mergeProp(prop3);

  // Test the resolved value of the accumulated Mix
  final expected = Border.all().copyWith(
    color: Colors.blue,
    width: 1.0,
    style: BorderStyle.dashed,
  );

  expect(merged, resolvesTo(expected));
});
```

--------------------------------

TITLE: Test Prop Resolution with resolvesTo
DESCRIPTION: Demonstrates how to use the `resolvesTo` matcher to verify that Mix Props resolve to their expected values. It covers regular values, Mix types, attributes, and tokens with custom contexts.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/test/helpers/testing_guide.md#_snippet_0

LANGUAGE: dart
CODE:
```
test('Props resolve to their values', () {
  final colorProp = Prop.value(Colors.red);
  expect(colorProp, resolvesTo(Colors.red));
});

test('Mix types resolve to Flutter types', () {
  final radiusMix = BorderRadiusMix.all(Radius.circular(8.0));
  expect(radiusMix, resolvesTo(BorderRadius.circular(8.0)));
  
  final edgeInsetsMix = EdgeInsetsMix.all(16.0);
  expect(edgeInsetsMix, resolvesTo(const EdgeInsets.all(16.0)));
});

test('Attributes resolve to specs', () {
  final attribute = OpacityModifierAttribute.only(opacity: 0.5);
  expect(attribute, resolvesTo(const OpacityModifier(0.5)));
});

test('Tokens resolve with custom context', () {
  const colorToken = MixToken<Color>('primary');
  final tokenProp = Prop.token(colorToken);
  
  final context = MockBuildContext(
    mixScopeData: MixScopeData.static(
      tokens: {colorToken: const Color(0xFF2196F3)},
    ),
  );
  
  expect(tokenProp, resolvesTo(const Color(0xFF2196F3), context: context));
});
```

--------------------------------

TITLE: Define Color and Space Tokens in Dart
DESCRIPTION: This snippet shows how to declare `ColorToken` and `SpaceToken` variables, which are fundamental for defining design system tokens within the Mix library.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_8

LANGUAGE: dart
CODE:
```
const $brandPrimary = ColorToken('brand.primary');
const $contentPadding = SpaceToken('layout.content.padding');
```

--------------------------------

TITLE: Combining and Overriding MixScopes
DESCRIPTION: Demonstrates two methods for managing scopes: combining multiple scopes using `MixScope.combine` and creating nested scopes for overriding specific token values in a particular part of the widget tree.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_7

LANGUAGE: dart
CODE:
```
final base = MixScope(
  colors: { ColorToken('brand.primary'): Colors.blue },
  child: const SizedBox(),
);

final feature = MixScope(
  colors: { ColorToken('brand.primary'): Colors.green },
  child: const SizedBox(),
);

final combined = MixScope.combine(
  scopes: [base, feature],
  child: MyApp(),
);

// Nested scope example:
MixScope(
  colors: { ColorToken('brand.primary'): Colors.blue },
  child: FeatureShell(
    child: MixScope(
      colors: { ColorToken('brand.primary'): Colors.green },
      child: FeatureWidget(),
    ),
  ),
)
```

--------------------------------

TITLE: Type Safety Example
DESCRIPTION: Illustrates the strong type safety enforced by Mix utilities, preventing the combination of incompatible styles from different utility types.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/spec_util_api.md#_snippet_19

LANGUAGE: dart
CODE:
```
// Type safe - BoxStyler methods on BoxSpecUtility
$box.color.red().padding.all(16)  ✓

// Type error - can't mix utilities
$box.color.red() + $text.fontSize(16)  ✗
```

--------------------------------

TITLE: Automated Content Migration Script (Bash)
DESCRIPTION: A bash script to automate the copying of content and assets, and renaming of meta files during the migration from Nextra to Fumadocs. It requires manual updates to `meta.json` and component imports afterward.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_8

LANGUAGE: bash
CODE:
```
#!/bin/bash
# Run from repository root

# Create directories
mkdir -p docs/content/docs/v1
mkdir -p docs/public

# Copy content
cp -r website/pages/docs/* docs/content/docs/v1/

# Copy assets (images, icons, etc.)
cp -r website/public/* docs/public/

# Rename meta files
find docs/content/docs/v1 -name "_meta.json" -exec sh -c 'mv "$1" "${1%/*}/meta.json"' _ {} \;

echo "Content migration completed. Review and update meta.json files manually."
echo "Don't forget to:"
echo "1. Update meta.json files to new format"
echo "2. Convert Nextra components to Fumadocs equivalents"
echo "3. Update image paths if needed"
echo "4. Update component imports (Steps, Callout, FileTree, Tabs, Bleed)"
echo "5. Test all components render correctly"
```

--------------------------------

TITLE: Fix: Test Token Resolution with Context - Dart
DESCRIPTION: Illustrates the correct way to test token resolution by providing the necessary build context, unlike the incorrect approach which lacks context.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/test/helpers/testing_guide.md#_snippet_8

LANGUAGE: dart
CODE:
```
// ❌ Wrong - tokens need context
expect(tokenProp, resolvesTo(Colors.blue));

// ✅ Right - provide context for tokens
final context = MockBuildContext(
  mixScopeData: MixScopeData.static(tokens: {token: Colors.blue}),
);
expect(tokenProp, resolvesTo(Colors.blue, context: context));
```

--------------------------------

TITLE: Set Text Alignment - Dart
DESCRIPTION: Defines the horizontal alignment of text within its container. Supports left, right, center, justify, start, and end alignments.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/utilities/text-utilities.md#_snippet_9

LANGUAGE: dart
CODE:
```
$text.textAlign.left()
$text.textAlign.right()
$text.textAlign.center()
$text.textAlign.justify()
$text.textAlign.start()
$text.textAlign.end()
```

--------------------------------

TITLE: Create a Custom EdgeInsetsGeometry Token in Mix
DESCRIPTION: Shows the process of creating a custom design token by extending the MixToken class. This example defines a token for EdgeInsetsGeometry and its corresponding reference class.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/guides/design-token.mdx#_snippet_2

LANGUAGE: dart
CODE:
```
class EdgeInsetsGeometryToken extends MixToken<EdgeInsetsGeometry> {
  const EdgeInsetsGeometryToken(super.name);

  @override
  EdgeInsetsGeometryRef call() => EdgeInsetsGeometryRef(Prop.token(this));
}
```

--------------------------------

TITLE: PressableBox Widget Styling and Usage
DESCRIPTION: Demonstrates how to use and style the PressableBox widget, combining Pressable functionality with Box styling. This example applies BoxStyler to set background color, padding, and rounded borders, and includes an onPress callback.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/stylewidgets.mdx#_snippet_5

LANGUAGE: dart
CODE:
```
PressableBox(
    style: BoxStyler()
      .color(Colors.blue)
      .paddingAll(16)
      .borderRounded(8),
    onPress: () => print('PressableBox pressed'),
    child: StyledText('Styled Button'),
  );
```

--------------------------------

TITLE: Dart Unit Tests for Type Discovery
DESCRIPTION: Provides example Dart unit tests for validating type discovery mechanisms. These tests verify the discovery of `Mixable<T>` implementations and the extraction of utility types for specific elements.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix_generator/type_registration_plan.md#_snippet_7

LANGUAGE: dart
CODE:
```
test('discovers Mixable<Color> implementation', () {
  final element = // mock ColorDto extending Mixable<Color>
  final type = TypeDiscovery.extractMixableType(element);
  expect(type, equals('Color'));
});

test('discovers utility for Color type', () {
  final element = // mock ColorUtility
  final type = TypeDiscovery.extractUtilityType(element);
  expect(type, equals('Color'));
});
```

--------------------------------

TITLE: Advanced StackBoxStyler Styling
DESCRIPTION: Demonstrates advanced styling techniques with StackBoxStyler, including complex layered designs with shadows, margins, constraints, and specific alignment and clipping behaviors. This example showcases the flexibility for creating sophisticated UI components.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_41

LANGUAGE: dart
CODE:
```
// Complex layered design
final complexStack = StackBoxStyler(
  decoration: DecorationMix(
    color: Colors.white,
    borderRadius: BorderRadiusGeometryMix.circular(20),
    boxShadow: [
      BoxShadowMix(
        color: Colors.black12,
        offset: Offset(0, 8),
        blurRadius: 16,
        spreadRadius: 0,
      ),
    ],
  ),
  padding: EdgeInsetsGeometryMix.all(0),
  margin: EdgeInsetsGeometryMix.all(16),
  constraints: BoxConstraintsMix(maxWidth: 400),
  stackAlignment: Alignment.topCenter,
  fit: StackFit.loose,
  clipBehavior: Clip.antiAlias,
);
```

--------------------------------

TITLE: Using MixTheme with Color Tokens (Dart)
DESCRIPTION: Demonstrates how to define and apply theme colors using ColorTokens and MixThemeData in Dart. It shows referencing a primary color token within a Style attribute.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/migration.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
const primaryColor = ColorToken('primary');
final theme = MixThemeData(
  colors: {
    primaryColor: Colors.blue,
  },
);

// ... body method ...
MixTheme(
  data: theme,
  Box(
    key: key,
    style: Style(
      $box.color.ref(primaryColor),
    ),
  )
)
```

--------------------------------

TITLE: Common Image Styling Patterns
DESCRIPTION: Provides examples of common image styling patterns using the Mix library's fluent API. These patterns cover various use cases like thumbnails, card backgrounds, profile pictures, and full-screen images, showcasing different style properties.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_74

LANGUAGE: dart
CODE:
```
final thumbnail = $image
  .width(80)
  .height(80)
  .fit.cover()
  .filterQuality.medium();
```

LANGUAGE: dart
CODE:
```
final cardBackground = $image
  .width(double.infinity)
  .height(180)
  .fit.cover()
  .color.black().withOpacity(0.1)
  .colorBlendMode.multiply();
```

LANGUAGE: dart
CODE:
```
final profilePic = $image
  .width(120)
  .height(120)
  .fit.cover()
  .alignment.center()
  .isAntiAlias(true)
  .filterQuality.high();
```

LANGUAGE: dart
CODE:
```
final fullscreenImage = $image
  .width(double.infinity)
  .height(double.infinity)
  .fit.cover()
  .alignment.center()
  .gaplessPlayback(true);
```

LANGUAGE: dart
CODE:
```
final iconImage = $image
  .width(24)
  .height(24)
  .fit.contain()
  .color.grey().shade700()
  .colorBlendMode.srcIn();
```

LANGUAGE: dart
CODE:
```
final responsiveImage = $image
  .fit.cover()
  .alignment.center()
  .filterQuality.high()
  .isAntiAlias(true)
  .matchTextDirection(true);
```

--------------------------------

TITLE: Enable Built-in Search in Fumadocs Layout
DESCRIPTION: Demonstrates how to enable and configure the built-in search functionality within the Fumadocs UI provider by setting `search.enabled` to true in `docs/app/layout.tsx`.

SOURCE: https://github.com/btwld/mix/blob/main/fumadocs_migration.md#_snippet_14

LANGUAGE: typescript
CODE:
```
import { RootProvider } from 'fumadocs-ui/provider';

export default function RootLayout({
  children,
}: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <RootProvider
          search={{
            enabled: true,
            // Configure search options
          }}
        >
          {children}
        </RootProvider>
      </body>
    </html>
  );
}
```

--------------------------------

TITLE: Cross Axis Alignment Configuration
DESCRIPTION: Set the alignment of items along the cross axis using $flex.crossAxisAlignment. Options include start, end, center, stretch, and baseline.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flex/flex_style_api.md#_snippet_2

LANGUAGE: dart
CODE:
```
$flex.crossAxisAlignment(CrossAxisAlignment.stretch)
$flex.crossAxisAlignment.stretch()
```

--------------------------------

TITLE: MixScope Widget Constructor and Methods in Dart
DESCRIPTION: The MixScope widget, an InheritedModel, facilitates theme data sharing down the widget tree. It includes factory constructor for initialization with various token maps and static methods for accessing and resolving tokens from the context.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_9

LANGUAGE: dart
CODE:
```
class MixScope extends InheritedModel<String> {
  /// Creates a MixScope with typed token maps
  factory MixScope({
    Map<MixToken, Object>? tokens,
    Map<ColorToken, Color>? colors,
    Map<TextStyleToken, TextStyle>? textStyles,
    Map<SpaceToken, double>? spaces,
    Map<RadiusToken, Radius>? radii,
    Map<BreakpointToken, Breakpoint>? breakpoints,
    List<Type>? orderOfModifiers,
    required Widget child,
    Key? key,
  });
  
  /// Access MixScope from context
  static MixScope of(BuildContext context, [String? aspect]);
  
  /// Resolve token value from nearest MixScope
  static T tokenOf<T>(MixToken<T> token, BuildContext context);
  
  /// Type-safe token resolution with error handling
  T getToken<T>(MixToken<T> token, BuildContext context);
}
```

--------------------------------

TITLE: Advanced FlexBox Styling in Dart
DESCRIPTION: Demonstrates advanced FlexBox styling techniques including gradient backgrounds with shadows and responsive layouts. These examples utilize the '$flexbox' library to create visually appealing and adaptive UI components.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flexbox/flexbox_style_api.md#_snippet_32

LANGUAGE: dart
CODE:
```
// Gradient background with shadow
final fancyContainer = $flexbox
  .gradient.linear(
    colors: [Colors.blue.shade400, Colors.purple.shade400],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  )
  .borderRadius(16)
  .padding.all(24)
  .direction(Axis.vertical)
  .mainAxisAlignment.center()
  .crossAxisAlignment.center()
  .spacing(16)
;

// Responsive layout
final responsiveLayout = $flexbox
  .color.white()
  .borderRadius(12)
  .padding.all(16)
  .constraints.maxWidth(600)
  .direction(Axis.horizontal)
  .mainAxisAlignment.spaceBetween()
  .crossAxisAlignment.stretch()
  .spacing(16);
```

--------------------------------

TITLE: Basic Box and Text Styling with Mix
DESCRIPTION: Demonstrates defining basic styles for Box widgets using BoxStyler and Text widgets using TextStyler. These classes provide a fluent API to chain styling properties like height, width, color, borders, font size, and font weight.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/introduction.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
final boxStyle = BoxStyler()
    .height(100)
    .width(100)
    .color(Colors.purple)
    .borderRounded(10);

final textStyle = TextStyler()
    .fontSize(20)
    .fontWeight(FontWeight.bold)
    .color(Colors.black);
```

--------------------------------

TITLE: Declare and Resolve Mix Tokens in Dart
DESCRIPTION: Demonstrates how to declare type-safe tokens using classes like ColorToken, SpaceToken, and TextStyleToken. It shows different ways to resolve these tokens, either through a reference system or by using the BuildContext.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_0

LANGUAGE: dart
CODE:
```
const primary = ColorToken('color.primary');
const spacingMd = SpaceToken('space.md');
const h1 = TextStyleToken('text.h1');

// Resolution options
final color1 = primary();                 // via reference system
final color2 = primary.resolve(context);  // via BuildContext
```

--------------------------------

TITLE: Advanced Typography Styling Example
DESCRIPTION: Illustrates advanced typography settings, including text decoration, underline color, letter spacing, and line height for decorated text, as well as applying shadows with blur and offset for visually enhanced text.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_util_api.md#_snippet_1

LANGUAGE: dart
CODE:
```
final decoratedText = $text
  .fontSize(20)
  .fontWeight.w600()
  .color.red()
  .decoration.underline()
  .decorationColor.blue()
  .letterSpacing(1.2)
  .height(1.4);

final shadowText = $text
  .fontSize(24)
  .fontWeight.bold()
  .color.white()
  .shadows([
    Shadow(
      color: Colors.black26,
      offset: Offset(1, 1),
      blurRadius: 2,
    ),
  ]);
```

--------------------------------

TITLE: Button Styling Utilities and Design Tokens in Dart
DESCRIPTION: Demonstrates the use of `ButtonMutableStyler` utilities to create references for button parts (self, label, container, flex, icon). It also shows how to define design tokens using Material theme colors and text styles, and how to create a base style for the button.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/creating-a-widget.mdx#_snippet_1

LANGUAGE: dart
CODE:
```
final _util = ButtonMutableStyler.self;
final _label = _util.label;
final _container = _util.container;
final _flex = _util.flex;
final _icon = _util.icon;

final _mdPrimary = $material.colorScheme.primary;
final _mdOnPrimary = $material.colorScheme.onPrimary;
final _mdButton = $material.textTheme.button;

Style get _baseStyle => Style(
  // Container 
  _container.borderRadius(6),
  _container.padding(8, 12),
  // Flex
  _flex.gap(8),
  _flex.mainAxisAlignment.center(),
  _flex.crossAxisAlignment.center(),
  _flex.mainAxisSize.min(),
  //Label
  _label.style.ref(_mdButton),
  // Icon
  _icon.size(18),
);
```

--------------------------------

TITLE: SpaceToken Implementation in Dart
DESCRIPTION: A concrete implementation of MixToken for double values, used for spacing and sizing. It overrides the call() method to return a SpaceRef, which is an extension type for double values.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_2

LANGUAGE: dart
CODE:
```
class SpaceToken extends MixToken<double> {
  const SpaceToken(super.name);
  
  @override
  double call() => SpaceRef.token(this);  // Extension type
}
```

--------------------------------

TITLE: Basic Box Styling with Mix
DESCRIPTION: Demonstrates creating a basic BoxStyler with width, height, color, and rounded borders. This showcases the fluent API for declarative styling.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/guides/styling.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
final style = BoxStyler()
  .width(240)
  .height(100)
  .color(Colors.blue)
  .borderRounded(12);
```

--------------------------------

TITLE: Switch to Material Integration in Dart
DESCRIPTION: Shows how to use `MixScope.withMaterial` to integrate Mix tokens with Material Design theming. This allows for automatic alignment with Material Theme properties and provides a way to override or add specific tokens.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_11

LANGUAGE: dart
CODE:
```
void main() {
  runApp(
    MixScope.withMaterial(
      // Add or override your own tokens
      colors: { $brandPrimary: Colors.indigo },
      child: const MyApp(),
    ),
  );
}
```

--------------------------------

TITLE: Dynamic Styling with Mix
DESCRIPTION: Demonstrates how to apply styles based on widget states like hover, using Mix's variant system.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/guides/dynamic-styling.mdx#_snippet_3

LANGUAGE: APIDOC
CODE:
```
## Applying Hover Styles with Mix

### Description
Apply styles to a widget when it is hovered over. Mix merges the variant styles with the base styles automatically.

### Method
`BoxStyler.onHovered(BoxStyler)`

### Parameters
*   `onHovered` (BoxStyler) - The style to apply when the widget is hovered.

### Request Example
```dart
final style = BoxStyler()
  .color(Colors.red)
  .height(100)
  .width(100)
  .borderRounded(10)
  .onHovered(BoxStyler().color(Colors.blue));
```

### Response
#### Success Response (200)
Applies the specified styles based on the widget's state.

#### Response Example
(Conceptual - applies styles dynamically)
```dart
// When hovered, color changes to blue
BoxStyler()
  .color(Colors.blue)
  .height(100)
  .width(100)
  .borderRounded(10);
```
```

--------------------------------

TITLE: Style Start Border Radius Directional (Dart)
DESCRIPTION: Styles the topStart and bottomStart of a Box Decoration's border radius. Supports uniform radius, circular, elliptical, and zeroing the radius.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/utilities/box-utilities.md#_snippet_61

LANGUAGE: dart
CODE:
```
$box.borderRadiusDirectional.start(10);
$box.borderRadiusDirectional.start.circular(10);
$box.borderRadiusDirectional.start.elliptical(10, 20);
$box.borderRadiusDirectional.start.zero();
```

--------------------------------

TITLE: Common Icon Styling Patterns
DESCRIPTION: Provides examples of reusable icon styling configurations for common UI elements like navigation icons, action buttons, status indicators, feature icons, and interactive icons.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_style_api.md#_snippet_57

LANGUAGE: dart
CODE:
```
// Navigation icons
final navIcon = $icon
  .color.grey.shade600()
  .size(24);

// Action button icons
final actionIcon = $icon
  .color.white()
  .size(20)
  .weight(500);

// Status icons with colors
final successIcon = $icon.color.green().size(16);
final warningIcon = $icon.color.orange().size(16);
final errorIcon = $icon.color.red().size(16);

// Large feature icons
final featureIcon = $icon
  .color.blue.shade700()
  .size(48)
  .weight(400)
  .shadow.large();

// Interactive icons with hover effects
final interactiveIcon = $icon
  .color.grey.shade700()
  .size(20)
  .animate(AnimationConfig(
    duration: Duration(milliseconds: 150),
    curve: Curves.easeInOut,
  ));
```

--------------------------------

TITLE: Setting Image Source with ImageSpecUtility
DESCRIPTION: Demonstrates how to set the image source using various methods provided by the ImageSpecUtility class, such as from assets, network URLs, files, or memory bytes.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_util_api.md#_snippet_0

LANGUAGE: dart
CODE:
```
ImageSpecUtility image;

// Set image provider
image.image(ImageProvider value);

// Set asset image
image.image.asset('path/to/asset.png');

// Set network image
image.image.network('http://example.com/image.jpg');

// Set file image
image.image.file(File('path/to/local/image.png'));

// Set memory image
image.image.memory(Uint8List.fromList([...]));
```

--------------------------------

TITLE: Common BoxStyler Styling Patterns in Dart
DESCRIPTION: Provides examples of common styling patterns using BoxStyler instance methods, such as card-like, button-like, and container styles, as well as advanced styling with gradients and hover effects.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_65

LANGUAGE: dart
CODE:
```
final cardStyle = BoxStyler()
  .color(Colors.white)
  .borderRounded(12)
  .shadowOnly(color: Colors.black12, offset: Offset(0, 2), blurRadius: 8)
  .paddingAll(16);

final buttonStyle = BoxStyler()
  .color(Colors.blue)
  .borderRounded(8)
  .paddingOnly(
    horizontal: 24,
    vertical: 12,
  )
  .borderAll(
    color: Colors.blue.shade700,
    width: 1
  );

final containerStyle = BoxStyler()
  .size(300, 200)
  .color(Colors.grey.shade100)
  .borderAll(color: Colors.grey)
  .paddingAll(20);

final advancedStyle = BoxStyler()
  .linearGradient(
    colors: [Colors.blue, Colors.purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  )
  .shapeRoundedRectangle(
    borderRadius: BorderRadiusMix.circular(16),
  )
  .wrapOpacity(0.9)
  .onHovered(BoxStyler().transform(
    Matrix4.identity()..scale(1.05),
  ));
```

--------------------------------

TITLE: Flexbox Alignment Control - Dart
DESCRIPTION: Controls how children are aligned along the cross axis in a flexbox layout. Supports start, end, center, stretch, and baseline alignments.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flexbox/flexbox_util_api.md#_snippet_25

LANGUAGE: dart
CODE:
```
final navBar = $flexbox
  .color.blue().shade800()
  .padding.horizontal(24).padding.vertical(12)
  .direction.horizontal()
  .mainAxisAlignment.spaceBetween()
  .crossAxisAlignment.center();
```

LANGUAGE: dart
CODE:
```
final constrainedContainer = $flexbox
  .width.fixed(300)
  .height.fixed(200)
  .color.grey().shade50()
  .border.all(color: Colors.grey.shade300)
  .borderRadius.circular(8)
  .padding.all(16)
  .direction.column()
  .crossAxisAlignment.stretch()
  .spacing(8);
```

--------------------------------

TITLE: StyledImage Widget Styling with ImageStyler
DESCRIPTION: Provides an example of styling the StyledImage widget, which replaces Flutter's Image widget. It uses ImageStyler to define the width and height of the image. The StyledImage widget takes an image source and a style object.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/stylewidgets.mdx#_snippet_4

LANGUAGE: dart
CODE:
```
final imageStyle = ImageStyler()
  .width(200)
  .height(150);

StyledImage(
  image: NetworkImage('https://example.com/image.png'),
  style: imageStyle,
);
```

--------------------------------

TITLE: Responsive Flex Layouts: Breakpoint and Theme Adjustments
DESCRIPTION: Illustrates how to create responsive flex layouts that adapt to different screen sizes (breakpoints) and theme variations (dark/light mode). This allows for flexible UI adaptation across devices.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flex/flex_util_api.md#_snippet_16

LANGUAGE: dart
CODE:
```
// Layout that changes direction on different screen sizes
final responsiveFlex = $flex
  .direction.vertical()
  .mainAxisAlignment.start()
  .spacing(16)
  .onBreakpoint(Breakpoint.md, $flex.direction.horizontal())
  .onBreakpoint(Breakpoint.lg, $flex.spacing(24));

// Theme-aware flex layout
final themeFlex = $flex
  .column()
  .spacing(12)
  .onDark($flex.spacing(16));
```

--------------------------------

TITLE: Basic Box Styling with Color and Gradient (Dart)
DESCRIPTION: Demonstrates creating a simple colored box with padding and a box with a linear gradient background. Uses the BoxSpecUtility for styling.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_18

LANGUAGE: dart
CODE:
```
final basicBox = $box
  .color.blue()
  .padding.all(16);

final gradientBox = $box
  .gradient.linear(
    colors: [Colors.blue, Colors.purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  )
  .borderRadius.circular(12);
```

--------------------------------

TITLE: FlexBoxSpecUtility Main Axis Alignment
DESCRIPTION: Configures alignment of children along the main axis of the flex container. Includes methods for start, end, center, spaceBetween, spaceAround, and spaceEvenly.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flexbox/flexbox_util_api.md#_snippet_10

LANGUAGE: dart
CODE:
```
import 'package:flutter/rendering.dart';

final styler = FlexBoxSpecUtility().mainAxisAlignment(MainAxisAlignment.center);
final styler = FlexBoxSpecUtility().mainAxisAlignment.start();
final styler = FlexBoxSpecUtility().mainAxisAlignment.end();
final styler = FlexBoxSpecUtility().mainAxisAlignment.center();
final styler = FlexBoxSpecUtility().mainAxisAlignment.spaceBetween();
final styler = FlexBoxSpecUtility().mainAxisAlignment.spaceAround();
final styler = FlexBoxSpecUtility().mainAxisAlignment.spaceEvenly();
```

--------------------------------

TITLE: Set Sweep Gradient
DESCRIPTION: Configures a sweep gradient for the box background, defining colors, stops, center, start angle, end angle, and tile mode. Requires DecorationStyleMixin.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_30

LANGUAGE: dart
CODE:
```
BoxStyler().sweepGradient(colors: [Color(0xFFF44336), Color(0xFFFFEB3B)], center: Alignment.center, startAngle: 0.0, endAngle: 3.14);
```

--------------------------------

TITLE: Style custom widget without Mix in Flutter
DESCRIPTION: Illustrates styling a custom widget in Flutter without using the Mix library. This example shows the traditional approach involving `StatefulWidget`, `MouseRegion`, and `Animated` widgets to handle styling and hover states, highlighting its verbosity.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/comparison.mdx#_snippet_1

LANGUAGE: dart
CODE:
```
class CustomWidget extends StatefulWidget {
  const CustomWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  bool _isHover = false;

  final _curve = Curves.linear;
  final _duration = const Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.cyan : Colors.blue;
    final textColor = isDark ? Colors.black : Colors.white;
    final borderRadius = BorderRadius.circular(10);

    final onHoverTextColor =
        isDark ? textColor.lighten(20) : textColor.darken(20);

    final onHoverBgColor =
        isDark ? backgroundColor.lighten(20) : backgroundColor.darken(30);

    return MouseRegion(
      onEnter: (event) {
        setState(() => _isHover = true);
      },
      onExit: (event) {
        setState(() => _isHover = false);
      },
      child: Material(
        elevation: _isHover ? 2 : 9,
        borderRadius: borderRadius,
        child: AnimatedScale(
          scale: _isHover ? 1.5 : 1,
          curve: _curve,
          duration: _duration,
          child: AnimatedContainer(
            curve: _curve,
            duration: _duration,
            height: 120,
            width: 120,
            padding:
                _isHover ? const EdgeInsets.all(10) : const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _isHover ? onHoverBgColor : backgroundColor,
              borderRadius: borderRadius,
            ),
            child: AnimatedAlign(
              alignment: _isHover ? Alignment.topLeft : Alignment.center,
              curve: _curve,
              duration: _duration,
              child: Text(
                'Custom Widget',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: _isHover ? onHoverTextColor : textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

--------------------------------

TITLE: StackBoxStyler Constructors
DESCRIPTION: Provides details on the different ways to construct a StackBoxStyler instance.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_18

LANGUAGE: APIDOC
CODE:
```
## StackBoxStyler Constructors

### StackBoxStyler({...}) → StackBoxStyler

Main constructor with optional parameters for all stack-box properties.

```dart
StackBoxStyler({
  // Box properties
  DecorationMix? decoration,
  DecorationMix? foregroundDecoration,
  EdgeInsetsGeometryMix? padding,
  EdgeInsetsGeometryMix? margin,
  AlignmentGeometry? alignment,
  BoxConstraintsMix? constraints,
  Matrix4? transform,
  AlignmentGeometry? transformAlignment,
  Clip? clipBehavior,
  // Stack properties
  AlignmentGeometry? stackAlignment,
  StackFit? fit,
  TextDirection? textDirection,
  Clip? stackClipBehavior,
  // Style properties
  List<VariantStyle<ZBoxSpec>>? variants,
})
```

### StackBoxStyler.create({...}) → StackBoxStyler

Internal constructor using `Prop<T>` types for advanced usage.

```dart
const StackBoxStyler.create({
  Prop<StyleSpec<BoxSpec>>? box,
  Prop<StyleSpec<StackSpec>>? stack,
  List<VariantStyle<ZBoxSpec>>? variants,
})
```

### StackBoxStyler.builder(StackBoxStyler Function(BuildContext)) → StackBoxStyler

Factory constructor for context-dependent stack-box styling.
```

--------------------------------

TITLE: StackStyler Constructors
DESCRIPTION: Details on how to create instances of the StackStyler class.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_style_api.md#_snippet_13

LANGUAGE: APIDOC
CODE:
```
## Constructors

### StackStyler({...}) → StackStyler
Main constructor with optional parameters for all stack properties.
```dart
StackStyler({
  AlignmentGeometry? alignment,
  StackFit? fit,
  TextDirection? textDirection,
  Clip? clipBehavior,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<StackSpec>>? variants,
})
```

### StackStyler.create({...}) → StackStyler
Internal constructor using `Prop<T>` types for advanced usage.
```dart
const StackStyler.create({
  Prop<AlignmentGeometry>? alignment,
  Prop<StackFit>? fit,
  Prop<TextDirection>? textDirection,
  Prop<Clip>? clipBehavior,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<StackSpec>>? variants,
})
```

### StackStyler.builder(StackStyler Function(BuildContext)) → StackStyler
Factory constructor for context-dependent stack styling.
```

--------------------------------

TITLE: Basic StyledIcon Usage
DESCRIPTION: Demonstrates the basic usage of the StyledIcon widget, setting the icon data and applying style properties like color and size using IconStyler.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/icon.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
StyledIcon(
  icon: Icons.star,
  style: IconStyler()
    .color(Colors.blue)
    .size(30),
);
```

--------------------------------

TITLE: Complex Layouts: Navigation Bar, Card Content, Button Group
DESCRIPTION: Provides examples of complex layout constructions using flex utilities, including navigation bars with spaced elements, card content with padding, and button groups aligned to the end. These showcase practical application of the library.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flex/flex_util_api.md#_snippet_21

LANGUAGE: dart
CODE:
```
// Navigation bar layout
final navBarFlex = $flex
  .row()
  .mainAxisAlignment.spaceBetween()
  .crossAxisAlignment.center()
  .mainAxisSize.max()
  .spacing(16)
  .wrap.padding(EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12));

// Card content layout
final cardContentFlex = $flex
  .column()
  .crossAxisAlignment.stretch()
  .spacing(16)
  .wrap.padding(EdgeInsets.all(20));

// Button group layout
final buttonGroupFlex = $flex
  .row()
  .mainAxisAlignment.end()
  .crossAxisAlignment.center()
  .spacing(12);
```

--------------------------------

TITLE: Main Axis Alignment Configuration
DESCRIPTION: Control the alignment of items along the main axis with $flex.mainAxisAlignment. Supports various alignment options like start, end, center, spaceBetween, spaceAround, and spaceEvenly.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flex/flex_style_api.md#_snippet_1

LANGUAGE: dart
CODE:
```
$flex.mainAxisAlignment(MainAxisAlignment.center)
$flex.mainAxisAlignment.center()
```

--------------------------------

TITLE: Using Sub-Utilities for Detailed Styling (Dart)
DESCRIPTION: Illustrates the use of sub-utilities within BoxSpecUtility for fine-grained control over padding, margin, and constraints, enabling detailed configurations.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_20

LANGUAGE: dart
CODE:
```
final paddedBox = $box
  .padding.only(
    left: 16,
    right: 16, 
    top: 24,
    bottom: 12,
  )
  .margin.horizontal(8);

final responsiveBox = $box
  .constraints.width(300)
  .minHeight.fixed(100)
  .maxHeight.fixed(400);
```

--------------------------------

TITLE: Defining CustomButton Variants in Dart
DESCRIPTION: Demonstrates how to define custom variants for a button component in Dart using the `Variant` class. It includes examples for button types (primary, destructive, link) and sizes (medium, large).

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/best-practices.mdx#_snippet_1

LANGUAGE: dart
CODE:
```
class CustomButtonType extends Variant {
  const CustomButtonType._(super.name);

  static const primary = CustomButtonType._('custom.button.primary');
  static const destructive = CustomButtonType._('custom.button.destructive');
  static const link = CustomButtonType._('custom.button.link');
}

class CustomButtonSize extends Variant {
  const CustomButtonSize._(super.name);

  static const medium = CustomButtonSize._('custom.button.medium');
  static const large = CustomButtonSize._('custom.button.large');
}
```

--------------------------------

TITLE: Responsive Image Layout and Theming
DESCRIPTION: Configures images to adapt to different screen sizes and themes. Supports setting infinite width for responsiveness and applying different image assets based on dark or light themes.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_util_api.md#_snippet_13

LANGUAGE: dart
CODE:
```
final responsiveImage = $image
  .image.asset('assets/hero.jpg')
  .width(double.infinity)
  .fit.cover()
  .alignment.center()
  .onBreakpoint(Breakpoint.md, $image.height(400))
  .onBreakpoint(Breakpoint.lg, $image.height(500));

final themeImage = $image
  .image.asset('assets/light_logo.png')
  .width(120)
  .height(40)
  .onDark($image.image.asset('assets/dark_logo.png'));
```

--------------------------------

TITLE: Direct BoxStyler Instantiation in Dart
DESCRIPTION: Demonstrates direct instantiation of BoxStyler using its constructor and the `create` factory method for more advanced configurations. It shows how to apply padding, decoration, and animation properties.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_61

LANGUAGE: dart
CODE:
```
final style = BoxStyler(
  padding: EdgeInsetsGeometryMix.all(16),
  decoration: DecorationMix(
    color: Colors.blue,
    borderRadius: BorderRadiusGeometryMix.circular(8),
  ),
  animation: AnimationConfig(duration: Duration(milliseconds: 300)),
);

final advancedStyle = BoxStyler.create(
  padding: Prop.value(EdgeInsets.all(16)),
  decoration: Prop.value(BoxDecoration(
    color: Colors.red,
    border: Border.all(width: 2, color: Colors.black),
    borderRadius: BorderRadius.circular(12),
  )),
  clipBehavior: Prop.value(Clip.antiAlias),
);
```

--------------------------------

TITLE: Set Directional Borders
DESCRIPTION: Applies borders based on text direction (start and end), making them RTL-aware. Includes options for color, width, style, and stroke alignment. Requires BorderStyleMixin.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_19

LANGUAGE: dart
CODE:
```
BoxStyler().borderStart(color: Color(0xFF00FF00), width: 1.0);
BoxStyler().borderEnd(width: 1.5, style: BorderStyle.dashed);
```

--------------------------------

TITLE: Avoid Overlapping Styles: Combine Styles Safely (Dart)
DESCRIPTION: Shows how to combine multiple styles using `Style.combine` to create distinct widget appearances like primary and secondary buttons, preventing style conflicts.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/ai.txt#_snippet_5

LANGUAGE: dart
CODE:
```
// Define simple, focused styles
final buttonBaseStyle = Style(
  $box.padding(12, 24),
  $box.borderRadius(8),
  $text.style.fontWeight.w600(),
);

final primaryButtonStyle = Style.combine([
  buttonBaseStyle,
  Style(
    $box.color.blue(),
    $text.style.color.white(),
    $on.hover($box.color.blue(700)),
    $on.press($box.color.blue(900)),
  ),
]);

final secondaryButtonStyle = Style.combine([
  buttonBaseStyle,
  Style(
    $box.border.all.color.blue(),
    $box.border.all.width(2),
    $text.style.color.blue(),
    $on.hover($box.color.blue(50)),
  ),
]);
```

--------------------------------

TITLE: Test Mix Types Resolution - Dart
DESCRIPTION: Verifies that Mix properties are correctly set and resolve to their expected Flutter types. It covers simple Mix types like BorderMix and BorderSideMix.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/test/helpers/testing_guide.md#_snippet_5

LANGUAGE: dart
CODE:
```
test('Mix properties are set and resolve correctly', () {
  final borderMix = BorderMix(
    color: Prop.value(Colors.green),
    width: Prop.value(4.0),
  );
  
  expect(borderMix.color, resolvesTo(Colors.green));
  expect(borderMix.width, resolvesTo(4.0));
});
```

LANGUAGE: dart
CODE:
```
test('Mix resolves to Flutter type', () {
  final borderSide = BorderSideMix(
    color: Prop.value(Colors.red),
    width: Prop.value(2.0),
  );
  
  const expectedBorderSide = BorderSide(color: Colors.red, width: 2.0);
  expect(borderSide, resolvesTo(expectedBorderSide));
});
```

--------------------------------

TITLE: Recommended BoxStyler Usage with Instance Methods in Dart
DESCRIPTION: Illustrates the recommended approach of building BoxStyler configurations by chaining instance methods. This method allows for incremental styling and is often more readable.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_62

LANGUAGE: dart
CODE:
```
final boxStyle = BoxStyler()
  .paddingAll(16)
  .color(Colors.blue)
  .borderRounded(8)
  .animate(AnimationConfig(duration: Duration(milliseconds: 300)));
```

--------------------------------

TITLE: TextStyler Constructors
DESCRIPTION: Provides documentation for the different constructors of the TextStyler class.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_24

LANGUAGE: APIDOC
CODE:
```
## TextStyler Constructors

### TextStyler({...}) → TextStyler

Main constructor with optional parameters for all text properties.

```dart
TextStyler({
  TextOverflow? overflow,
  StrutStyleMix? strutStyle,
  TextAlign? textAlign,
  TextScaler? textScaler,
  int? maxLines,
  TextStyleMix? style,
  TextWidthBasis? textWidthBasis,
  TextHeightBehaviorMix? textHeightBehavior,
  TextDirection? textDirection,
  bool? softWrap,
  List<Directive<String>>? textDirectives,
  Color? selectionColor,
  String? semanticsLabel,
  Locale? locale,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<TextSpec>>? variants,
})
```

### TextStyler.create({...}) → TextStyler

Internal constructor using `Prop<T>` types for advanced usage.

```dart
const TextStyler.create({
  Prop<TextOverflow>? overflow,
  Prop<StrutStyle>? strutStyle,
  Prop<TextAlign>? textAlign,
  Prop<TextScaler>? textScaler,
  Prop<int>? maxLines,
  Prop<TextStyle>? style,
  Prop<TextWidthBasis>? textWidthBasis,
  Prop<TextHeightBehavior>? textHeightBehavior,
  Prop<TextDirection>? textDirection,
  Prop<bool>? softWrap,
  List<Directive<String>>? textDirectives,
  Prop<Color>? selectionColor,
  Prop<String>? semanticsLabel,
  Prop<Locale>? locale,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<TextSpec>>? variants,
})
```

### TextStyler.builder(TextStyler Function(BuildContext)) → TextStyler

Factory constructor for context-dependent text styling.
```

--------------------------------

TITLE: Dart: Using Custom Vertical Gradient Utility
DESCRIPTION: Illustrates how to use the custom-created vertical gradient utility within Mix styles in Dart. It shows examples for both the getter-based extension and the recommended function-based extension, demonstrating their application with color definitions.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/extending-utilities.md#_snippet_3

LANGUAGE: dart
CODE:
```
final style = Style(
    /// Approach 1:
    $box.linear.gradient.vertical.colors([Colors.blue, Colors.green]),
    /// Approach 2:
    $box.linearGradient.vertical(),
    $box.linearGradient.colors([Colors.blue, Colors.green]),
);

```

--------------------------------

TITLE: ImageStyler Core Methods
DESCRIPTION: Core methods for creating, resolving, and merging ImageStyler configurations.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_45

LANGUAGE: APIDOC
CODE:
```
## POST /api/imagestyler/call

### Description
Creates a StyledImage widget with optional parameters for advanced image handling.

### Method
POST

### Endpoint
/api/imagestyler/call

### Parameters
#### Request Body
- **image** (ImageProvider?) - The image provider.
- **frameBuilder** (ImageFrameBuilder?) - Builder for the image frames.
- **loadingBuilder** (ImageLoadingBuilder?) - Builder for loading state.
- **errorBuilder** (ImageErrorWidgetBuilder?) - Builder for error state.
- **opacity** (Animation<double>?) - Opacity animation.

### Request Example
```json
{
  "image": "some_image_provider",
  "opacity": "some_animation_object"
}
```

### Response
#### Success Response (200)
- **styledImage** (StyledImage) - The created StyledImage widget.

#### Response Example
```json
{
  "styledImage": "styled_image_widget_representation"
}
```
```

LANGUAGE: APIDOC
CODE:
```
## POST /api/imagestyler/resolve

### Description
Resolves all properties using the provided context, converting tokens and contextual values into concrete specifications.

### Method
POST

### Endpoint
/api/imagestyler/resolve

### Parameters
#### Request Body
- **context** (BuildContext) - The build context for resolution.

### Request Example
```json
{
  "context": "build_context_object"
}
```

### Response
#### Success Response (200)
- **styleSpec** (StyleSpec<ImageSpec>) - The resolved style specification.

#### Response Example
```json
{
  "styleSpec": "resolved_style_spec_representation"
}
```
```

LANGUAGE: APIDOC
CODE:
```
## POST /api/imagestyler/merge

### Description
Merges this ImageStyler with another, with the other's properties taking precedence for non-null values.

### Method
POST

### Endpoint
/api/imagestyler/merge

### Parameters
#### Request Body
- **other** (ImageStyler?) - The ImageStyler to merge with.

### Request Example
```json
{
  "other": "another_imagestyler_object"
}
```

### Response
#### Success Response (200)
- **mergedImageStyler** (ImageStyler) - The merged ImageStyler.

#### Response Example
```json
{
  "mergedImageStyler": "merged_imagestyler_object"
}
```
```

--------------------------------

TITLE: IconStyler Constructors
DESCRIPTION: Provides different ways to construct an IconStyler instance, including a main constructor with optional parameters, an internal constructor for advanced usage with Prop types, and a factory constructor for context-dependent styling.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_style_api.md#_snippet_15

LANGUAGE: APIDOC
CODE:
```
## IconStyler Constructors

### IconStyler({...}) → IconStyler
Main constructor with optional parameters for all icon properties.
```dart
IconStyler({
  Color? color,
  double? size,
  // ... other parameters
})
```

### IconStyler.create({...}) → IconStyler
Internal constructor using `Prop<T>` types for advanced usage.
```dart
const IconStyler.create({
  Prop<Color>? color,
  Prop<double>? size,
  // ... other parameters
})
```

### IconStyler.builder(IconStyler Function(BuildContext)) → IconStyler
Factory constructor for context-dependent icon styling.
```

--------------------------------

TITLE: Token Error Handling
DESCRIPTION: Implements error handling for token retrieval. It checks if a token exists in the scope and if the resolved value matches the expected type, throwing a `StateError` if either condition fails.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/token-migration-guide.md#_snippet_19

LANGUAGE: dart
CODE:
```
T getToken<T>(MixToken<T> token, BuildContext context) {
  final value = _tokens?[token];
  if (value == null) {
    throw StateError('Token "${token.name}" not found in scope');
  }
  
  if (value is T) {
    return value as T;
  }
  
  throw StateError(
    'Token "${token.name}" resolved to ${value.runtimeType}, expected $T',
  );
}
```

--------------------------------

TITLE: Flex Cross Axis Alignment Configuration
DESCRIPTION: Define the alignment of children along the cross axis of a flex container. Supports alignment to start, end, center, stretching to fill the axis, and baseline alignment.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flex/flex_util_api.md#_snippet_2

LANGUAGE: Mix
CODE:
```
$flex.crossAxisAlignment.start()
$flex.crossAxisAlignment.end()
$flex.crossAxisAlignment.center()
$flex.crossAxisAlignment.stretch()
$flex.crossAxisAlignment.baseline()
```

--------------------------------

TITLE: Flex Main Axis Alignment Configuration
DESCRIPTION: Control how children are aligned along the main axis of a flex container. Offers various predefined alignment options like start, end, center, spaceBetween, spaceAround, and spaceEvenly.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flex/flex_util_api.md#_snippet_1

LANGUAGE: Mix
CODE:
```
$flex.mainAxisAlignment.start()
$flex.mainAxisAlignment.end()
$flex.mainAxisAlignment.center()
$flex.mainAxisAlignment.spaceBetween()
$flex.mainAxisAlignment.spaceAround()
$flex.mainAxisAlignment.spaceEvenly()
```

--------------------------------

TITLE: Testing Commands After Phase 1 (Icon)
DESCRIPTION: These commands execute tests specifically for the Icon module and related scope providers after Phase 1 of the project refactoring.

SOURCE: https://github.com/btwld/mix/blob/main/mix_architecture_consolidation_plan.md#_snippet_22

LANGUAGE: bash
CODE:
```
# After Phase 1 (Icon):
melos exec --scope="mix" -- flutter test test/src/specs/icon/
melos exec --scope="mix" -- flutter test test/src/providers/icon_scope_test.dart
```

--------------------------------

TITLE: Test Spec Attributes with Mixed Prop Types - Dart
DESCRIPTION: Demonstrates testing spec attributes with properties of different types (value and mix) and how they are merged. It shows replacement for simple values and accumulation for mix types.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/test/helpers/testing_guide.md#_snippet_4

LANGUAGE: dart
CODE:
```
test('spec attribute with mixed prop types', () {
  final attribute = BoxSpecAttribute(
    width: Prop.value(100.0),                    // Prop<double> - replacement merge
    padding: Prop.mix(EdgeInsetsMix.all(16.0)), // Prop<EdgeInsetsGeometry> - accumulation merge
  );

  expect(attribute.$width, resolvesTo(100.0));
  expect(attribute.$padding, resolvesTo(const EdgeInsets.all(16.0)));
});
```

LANGUAGE: dart
CODE:
```
test('spec attribute merging with different prop types', () {
  final base = BoxSpecAttribute(
    width: Prop.value(100.0),
    padding: Prop.mix(EdgeInsetsMix.only(left: 8.0)),
  );

  final override = BoxSpecAttribute(
    width: Prop.value(200.0),                     // Will replace
    padding: Prop.mix(EdgeInsetsMix.only(right: 16.0)), // Will accumulate
  );

  final merged = base.merge(override);

  // Replacement: second wins
  expect(merged.$width, resolvesTo(200.0));

  // Accumulation: both are applied
  expect(merged.$padding, resolvesTo(const EdgeInsets.only(left: 8.0, right: 16.0)));
});
```

LANGUAGE: dart
CODE:
```
test('spec attribute resolves to spec', () {
  final attribute = BoxSpecAttribute(
    width: Prop.value(150.0),
    height: Prop.value(200.0),
  );

  const expectedSpec = BoxSpec(width: 150.0, height: 200.0);
  expect(attribute, resolvesTo(expectedSpec));
});
```

--------------------------------

TITLE: Button Styling Utilities and Design Tokens (Dart)
DESCRIPTION: Demonstrates how to define styling utilities and use design tokens for a CustomButton. It shows referencing ButtonMutableStyler utilities and Material theme tokens like colorScheme.primary and textTheme.button to create a base style.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/creating-a-widget.md#_snippet_7

LANGUAGE: dart
CODE:
```
final _util = ButtonMutableStyler.self;
final _label = _util.label;
final _container = _util.container;
final _flex = _util.flex;
final _icon = _util.icon;
```

LANGUAGE: dart
CODE:
```
final _mdPrimary = $material.colorScheme.primary;
final _mdOnPrimary = $material.colorScheme.onPrimary;
final _mdButton = $material.textTheme.button;
```

LANGUAGE: dart
CODE:
```
Style get _baseStyle => Style(
  // Container 
  _container.borderRadius(6),
  _container.padding(8, 12),
  // Flex
  _flex.gap(8),
  _flex.mainAxisAlignment.center(),
  _flex.crossAxisAlignment.center(),
  _flex.mainAxisSize.min(),
  //Label
  _label.style.ref(_mdButton),
  // Icon
  _icon.size(18),
);
```

--------------------------------

TITLE: Specify MixableField with @MixableField annotation
DESCRIPTION: This Dart snippet demonstrates how to use the @MixableField annotation to define a mixable property. It includes an example of specifying DTO type and utility properties with aliases for code generation.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix_generator/README.md#_snippet_3

LANGUAGE: dart
CODE:
```
import 'package:mix_generator/mix_generator.dart';

@MixableField(
  dto: MixableFieldDto(type: BoxConstraintsDto),
  utilities: [
    MixableFieldUtility(
      properties: [
        (path: 'minWidth', alias: 'minWidth'),
        (path: 'maxWidth', alias: 'maxWidth'),
      ],
    ),
  ],
)
final BoxConstraints? constraints;
```

--------------------------------

TITLE: Set Directional Corner Radii
DESCRIPTION: Sets border radius for corners based on text direction (start and end), ensuring RTL compatibility. Uses Radius objects for customization. Requires BorderRadiusStyleMixin.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_23

LANGUAGE: dart
CODE:
```
BoxStyler().borderRadiusTopStart(Radius.circular(8.0));
BoxStyler().borderRadiusBottomEnd(Radius.circular(10.0));
```

--------------------------------

TITLE: Dynamic Styling with State and Context in Mix
DESCRIPTION: Illustrates how to create dynamic styles that respond to widget states (hovered) and context (dark mode) using Mix's fluent API. This allows for interactive and context-aware UI elements.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/introduction.mdx#_snippet_1

LANGUAGE: dart
CODE:
```
final buttonStyle = BoxStyler()
    .height(50)
    .borderRounded(25)
    .color(Colors.blue)
    .onHovered(BoxStyler().color(Colors.blue.shade700))
    .onDark(BoxStyler().color(Colors.blue.shade200));
```

--------------------------------

TITLE: Use Tokens in UI Styles (BoxStyler) in Dart
DESCRIPTION: Illustrates how to consume defined tokens like `$brandPrimary` and `$contentPadding` within UI component styling using `BoxStyler`. It shows applying color and padding based on token values.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_10

LANGUAGE: dart
CODE:
```
class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color($brandPrimary())
        .padding(.all($contentPadding()))
        .borderRadius(.all(const Radius.circular(12)));

    return Box(style: style, child: const Text('Press me'));
  }
}
```

--------------------------------

TITLE: Dynamic and Context-Aware Styling with Variants
DESCRIPTION: Shows how to apply context-aware styling using variants like 'onHovered' and 'onDark'. This enables responsive designs that react to different states and contexts.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/guides/styling.mdx#_snippet_2

LANGUAGE: dart
CODE:
```
final button = BoxStyler()
  .color(Colors.blue)
  .onHovered(BoxStyler().color(Colors.blue.shade700))
  .onDark(BoxStyler().color(Colors.blue.shade200));
```

--------------------------------

TITLE: Common FlexBox Patterns in Dart
DESCRIPTION: Provides examples of common FlexBox layouts for UI elements such as navigation bars, card content, toolbars, status indicators, and form sections. These patterns utilize the '$flexbox' library for styling and layout properties.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flexbox/flexbox_style_api.md#_snippet_31

LANGUAGE: dart
CODE:
```
// Navigation bar
final navbar = $flexbox
  .color.white()
  .padding.symmetric(horizontal: 16, vertical: 12)
  .border.bottom(color: Colors.grey.shade200)
  .direction(Axis.horizontal)
  .mainAxisAlignment.spaceBetween()
  .crossAxisAlignment.center();

// Card content with header
final cardContent = $flexbox
  .color.white()
  .borderRadius(12)
  .padding.all(16)
  .border.all(color: Colors.grey.shade200)
  .direction(Axis.vertical)
  .crossAxisAlignment.stretch()
  .spacing(12);

// Toolbar
final toolbar = $flexbox
  .color.grey().shade50()
  .padding.all(8)
  .border.bottom()
  .direction(Axis.horizontal)
  .mainAxisAlignment.end()
  .spacing(8);

// Status indicator
final statusCard = $flexbox
  .color.green().shade50()
  .border.all(color: Colors.green.shade200)
  .borderRadius(8)
  .padding.all(12)
  .direction(Axis.horizontal)
  .crossAxisAlignment.center()
  .spacing(8);

// Form section
final formSection = $flexbox
  .color.grey().shade50()
  .borderRadius(8)
  .padding.all(16)
  .direction(Axis.vertical)
  .crossAxisAlignment.stretch()
  .spacing(16);
```

--------------------------------

TITLE: Generate Class Utility with Constants using @MixableFieldUtility
DESCRIPTION: This Dart example demonstrates generating a utility class for class constants using @MixableFieldUtility. It defines a `BorderRadius` class with static constants and a `BorderRadiusUtility` to access these constants as attributes.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix_generator/README.md#_snippet_5

LANGUAGE: dart
CODE:
```
// Define a class with constants
class BorderRadius {
  final double radius;
  
  const BorderRadius(this.radius);
  
  static const BorderRadius none = BorderRadius(0);
  static const BorderRadius small = BorderRadius(4);
  static const BorderRadius large = BorderRadius(16);
}

// Create a utility class for the class constants
@MixableFieldUtility()
class BorderRadiusUtility extends MixUtility<BorderRadiusAttribute, BorderRadius> {
  const BorderRadiusUtility(super.builder);
}

// After generation, you can use it like:
// final radiusUtility = BorderRadiusUtility((radius) => BorderRadiusAttribute(radius));
// final smallRadius = radiusUtility.small();
// final largeRadius = radiusUtility.large();
```

--------------------------------

TITLE: Basic Pressable Usage
DESCRIPTION: Demonstrates the fundamental usage of the Pressable widget to handle a simple press event.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/pressable.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
Pressable(
  onPress: () => print('Pressed!'),
  child: StyledText('Press Me'),
);
```

--------------------------------

TITLE: Create Custom Design Tokens
DESCRIPTION: Demonstrates how to create custom design tokens for colors and text styles in Mix. It defines token categories and instantiates them with unique names for use in the theme.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/theming.md#_snippet_0

LANGUAGE: dart
CODE:
```
const primary = ColorToken('primary');
```

LANGUAGE: dart
CODE:
```
final primaryColorToken = $token.color.primary;
final headline1TextStyleToken = $token.textStyle.headline1;
```

LANGUAGE: dart
CODE:
```
const $token = MyThemeToken();

class MyThemeToken {
  const MyThemeToken();

  final color = const MyThemeColorToken();
  final textStyle = const MyThemeTextStyleToken();
}

class MyThemeColorToken {
  const MyThemeColorToken();

  ColorToken get primary => const ColorToken('primary-color');
  ColorToken get onPrimary => const ColorToken('on-primary-color');
  ColorToken get surface => const ColorToken('surface-color');
  ColorToken get onSurface => const ColorToken('on-surface-color');
  ColorToken get onSurfaceVariant =>
      const ColorToken('on-surface-variant-color');
}

class MyThemeTextStyleToken {
  const MyThemeTextStyleToken();

  TextStyleToken get headline1 => const TextStyleToken('headline1');
  TextStyleToken get headline2 => const TextStyleToken('headline2');
  TextStyleToken get headline3 => const TextStyleToken('headline3');
  TextStyleToken get body => const TextStyleToken('body');
  TextStyleToken get callout => const TextStyleToken('callout');
}
```

--------------------------------

TITLE: Basic Image Styling with Dimensions and Fit
DESCRIPTION: Applies basic styling to an image, including setting its dimensions and fitting strategy. Supports loading images from assets or network URLs.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_util_api.md#_snippet_11

LANGUAGE: dart
CODE:
```
final basicImage = $image
  .image.asset('assets/photo.jpg')
  .width(200)
  .height(150);

final fittedImage = $image
  .image.network('https://example.com/image.jpg')
  .width(300)
  .height(200)
  .fit.cover();
```

--------------------------------

TITLE: ImageStyler Constructors
DESCRIPTION: Constructors for creating ImageStyler instances, including a main constructor with optional parameters, an internal constructor using Prop types, and a factory constructor for context-dependent styling.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_13

LANGUAGE: APIDOC
CODE:
```
## ImageStyler Constructors

### ImageStyler({...}) → ImageStyler
Main constructor with optional parameters for all image properties.
```dart
ImageStyler({
  ImageProvider<Object>? image,
  double? width,
  double? height,
  Color? color,
  ImageRepeat? repeat,
  BoxFit? fit,
  AlignmentGeometry? alignment,
  Rect? centerSlice,
  FilterQuality? filterQuality,
  BlendMode? colorBlendMode,
  String? semanticLabel,
  bool? excludeFromSemantics,
  bool? gaplessPlayback,
  bool? isAntiAlias,
  bool? matchTextDirection,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<ImageSpec>>? variants,
})
```

### ImageStyler.create({...}) → ImageStyler
Internal constructor using `Prop<T>` types for advanced usage.
```dart
const ImageStyler.create({
  Prop<ImageProvider<Object>>? image,
  Prop<double>? width,
  Prop<double>? height,
  Prop<Color>? color,
  Prop<ImageRepeat>? repeat,
  Prop<BoxFit>? fit,
  Prop<AlignmentGeometry>? alignment,
  Prop<Rect>? centerSlice,
  Prop<FilterQuality>? filterQuality,
  Prop<BlendMode>? colorBlendMode,
  Prop<String>? semanticLabel,
  Prop<bool>? excludeFromSemantics,
  Prop<bool>? gaplessPlayback,
  Prop<bool>? isAntiAlias,
  Prop<bool>? matchTextDirection,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<ImageSpec>>? variants,
})
```

### ImageStyler.builder(ImageStyler Function(BuildContext)) → ImageStyler
Factory constructor for context-dependent image styling.
```

--------------------------------

TITLE: Create a Profile Button Component with Mix
DESCRIPTION: A StatelessWidget named ProfileButton that displays a styled button. It utilizes Mix primitive widgets and theme tokens (e.g., $token.color.primary, $token.radius.large) for consistent styling. The button takes a 'label' string as input.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/theming.mdx#_snippet_6

LANGUAGE: dart
CODE:
```
class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Box(
      style: Style(
        $box.height(50),
        $box.width(double.infinity),
        $box.color.ref($token.color.primary),
        $box.alignment.center(),
        $box.borderRadius.all.ref($token.radius.large),
        $text.style.ref($token.textStyle.headline3),
        $text.style.color.ref($token.color.onPrimary),
      ),
      child: StyledText(
        label,
      ),
    );
  }
}
```

--------------------------------

TITLE: FlexBox Widget Styling with FlexBoxStyler
DESCRIPTION: Illustrates styling for FlexBox, ColumnBox, and RowBox widgets, which wrap Flutter's Flex, Column, and Row widgets. This example uses FlexBoxStyler to set main axis alignment, color, and direction. The FlexBox widget accepts a style and a list of children.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/stylewidgets.mdx#_snippet_1

LANGUAGE: dart
CODE:
```
final flexStyle = FlexBoxStyler()
    .mainAxisAlignment(MainAxisAlignment.spaceBetween)
    .color(Colors.blue)
    .direction(Axis.vertical);

FlexBox(
  style: flexStyle,
  children: [Text('Item 1'), Text('Item 2'), Text('Item 3')],
);
```

--------------------------------

TITLE: Generate MixableType class with @MixableType annotation
DESCRIPTION: This Dart code illustrates the use of the @MixableType annotation for generating code for a mixable type. It includes the necessary imports and the part directive. The example shows a generic class `ValueDto` with options for merging lists, generating utility classes, and generating value extensions for Dto conversion.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix_generator/README.md#_snippet_2

LANGUAGE: dart
CODE:
```
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

part 'value_dto.g.dart';

@MixableType()
final class ValueDto<Value> extends Mixable<Value> with _$ValueDto {
  final String? name;
  final int? age;

  const ValueDto({this.name, this.age});
}
```

--------------------------------

TITLE: Define a Basic Style in Flutter
DESCRIPTION: Demonstrates how to define a basic style using the Mix library. This includes setting properties like height, width, color, and border radius for a box element.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/README.md#_snippet_0

LANGUAGE: dart
CODE:
```
final style = Style(
  $box.height(100),
  $box.width(100),
  $box.color.purple(),
  $box.borderRadius(10),
);
```

--------------------------------

TITLE: Variant-Based Styling for Responsiveness (Dart)
DESCRIPTION: Shows how to apply styles based on breakpoints and dark mode using BoxSpecUtility, enabling responsive and theme-aware designs.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_22

LANGUAGE: dart
CODE:
```
final responsiveBox = $box
  .color.blue()
  .padding.all(16)
  .onBreakpoint(Breakpoint.md, $box.padding.all(24))
  .onDark($box.color.grey().shade800());
```

--------------------------------

TITLE: Testing Commands After Phase 2 (Text)
DESCRIPTION: These commands execute tests for the Text module and its scope providers after Phase 2 of the project refactoring.

SOURCE: https://github.com/btwld/mix/blob/main/mix_architecture_consolidation_plan.md#_snippet_23

LANGUAGE: bash
CODE:
```
# After Phase 2 (Text):
melos exec --scope="mix" -- flutter test test/src/specs/text/
melos exec --scope="mix" -- flutter test test/src/providers/text_scope_test.dart
```

--------------------------------

TITLE: StackSpecUtility: Overlay Layouts
DESCRIPTION: Illustrates creating overlay layouts with the StackSpecUtility, such as image overlays with centered content or badge overlays positioned at the top-right. This includes setting alignment, fit, clip behavior, and text direction.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_util_api.md#_snippet_1

LANGUAGE: dart
CODE:
```
final imageOverlay = $stack
  .alignment.center()
  .fit.expand()
  .clipBehavior.antiAlias();

final badgeOverlay = $stack
  .alignment.topRight()
  .fit.loose()
  .textDirection.ltr();
```

--------------------------------

TITLE: Setting Default Modifier Order in MixScope
DESCRIPTION: Explains how to define the default order for Mix modifiers using the `orderOfModifiers` parameter in MixScope. This allows for consistent application of modifiers across widgets and enables aspect-based rebuilds when the order changes.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/doc/mix-scope-and-theming.md#_snippet_6

LANGUAGE: dart
CODE:
```
MixScope(
  orderOfModifiers: [/* e.g., OpacityModifier, PaddingModifier, ... */],
  child: MyApp(),
)
```

--------------------------------

TITLE: Media Player Stack Configurations
DESCRIPTION: Demonstrates stack configurations for media players, including video players with controls overlays and audio players with floating controls. This highlights flexible positioning and padding for UI elements.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_util_api.md#_snippet_21

LANGUAGE: dart
CODE:
```
// Video player with controls overlay
final videoPlayer = $stack
  .alignment.center()
  .fit.expand()
  .clipBehavior.hardEdge();

// Audio player with floating controls
final audioPlayer = $stack
  .alignment.bottomCenter()
  .fit.loose()
  .wrap.padding(EdgeInsets.all(16));
```

--------------------------------

TITLE: Testing Commands After Phase 4 (Flex)
DESCRIPTION: These commands execute tests for both the Flex and FlexBox modules after Phase 4 of the project refactoring, covering the flex system updates.

SOURCE: https://github.com/btwld/mix/blob/main/mix_architecture_consolidation_plan.md#_snippet_25

LANGUAGE: bash
CODE:
```
# After Phase 4 (Flex):
melos exec --scope="mix" -- flutter test test/src/specs/flex/
melos exec --scope="mix" -- flutter test test/src/specs/flexbox/
```

--------------------------------

TITLE: Stack Fit Utilities
DESCRIPTION: Illustrates the use of stack fit utilities to control how layers are sized within the ZBox. Options include StackFit.loose and StackFit.expand.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/stack.mdx#_snippet_2

LANGUAGE: dart
CODE:
```
// StackFit.loose
$stack.fit.loose();
```

LANGUAGE: dart
CODE:
```
// StackFit.expand
$stack.fit.expand();
```

--------------------------------

TITLE: BoxSpecUtility - Core Methods
DESCRIPTION: Includes methods for applying animations and merging styles.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_15

LANGUAGE: APIDOC
CODE:
```
## BoxSpecUtility - Core Methods

### Description
Core methods for styling operations.

### Methods
- **animate(AnimationConfig animation)**: Applies animation configuration.
- **merge(Style<BoxSpec>? other)**: Merges this utility with another style.

### Endpoint
`$box`

### Parameters
#### Request Body
- **animation** (AnimationConfig) - Required for `animate` - Animation configuration object.
- **other** (Style<BoxSpec>?) - Optional for `merge` - Another style to merge with.
```

--------------------------------

TITLE: BoxStyler Border Helpers
DESCRIPTION: Illustrates using direct border methods on BoxStyler for applying borders to all sides or specific sides with custom colors and widths.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/utility-first.mdx#_snippet_2

LANGUAGE: dart
CODE:
```
// Red border on all sides
BoxStyler().borderAll(color: Colors.red);

// Top border only with custom width
BoxStyler().borderTop(color: Colors.red, width: 2);
```

--------------------------------

TITLE: Create Image Widgets with Styles
DESCRIPTION: Demonstrates different ways to create image widgets using the Mix library's styling capabilities. Includes using the Style.image() factory, the StyledImage widget directly, and invoking the style object.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_73

LANGUAGE: dart
CODE:
```
final widget = Style.image(
  width: 200,
  height: 150,
  fit: BoxFit.cover,
)(
  image: NetworkImage('https://example.com/image.jpg'),
  loadingBuilder: (context, child, loadingProgress) => 
    loadingProgress == null ? child : CircularProgressIndicator(),
);
```

LANGUAGE: dart
CODE:
```
final widget = StyledImage(
  style: imageStyle,
  image: NetworkImage('https://example.com/image.jpg'),
);
```

LANGUAGE: dart
CODE:
```
final widget = imageStyle(
  image: NetworkImage('https://example.com/image.jpg'),
);
```

--------------------------------

TITLE: BoxSpecUtility - Core Methods
DESCRIPTION: Includes methods for applying animation configurations and merging styles. `animate` applies animation, and `merge` combines styles.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_6

LANGUAGE: dart
CODE:
```
// Applies animation configuration
$box.animate(AnimationConfig.defaultAnimation())

// Merges this utility with another style
$box.merge(otherStyle)
```

--------------------------------

TITLE: TextStyler Instance Methods - Scaling & Layout
DESCRIPTION: Instance methods for managing text scaling and layout behavior.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_47

LANGUAGE: APIDOC
CODE:
```
### Text Scaling & Layout

- **textScaler(TextScaler value)** → TextStyler - Sets the text scaling factor for accessibility
- **textHeightBehavior(TextHeightBehaviorMix value)** → TextStyler - Sets how text height is calculated and applied
- **strutStyle(StrutStyleMix value)** → TextStyler - Sets the strut style for consistent text line heights
```

--------------------------------

TITLE: Debug Code Generators with VM Service
DESCRIPTION: Command to run build_runner with the VM service enabled for debugging. Requires connecting a debugger to localhost:8888.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix_generator/README.md#_snippet_8

LANGUAGE: bash
CODE:
```
dart --enable-vm-service=8888 --pause-isolates-on-start run build_runner build --verbose
```

--------------------------------

TITLE: Composing and Extending Styles
DESCRIPTION: Showcases how to compose styles and extend existing styles with new variants.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/guides/dynamic-styling.mdx#_snippet_4

LANGUAGE: APIDOC
CODE:
```
## Composing and Extending Styles with Variants

### Description
Reuse styles and extend them with new or modified variants. This allows for complex style hierarchies.

### Method
`styleA.onHovered(BoxStyler()..property(value))`

### Parameters
*   `onHovered` (BoxStyler) - The new or modified style to apply when hovered.

### Request Example
```dart
final styleA = BoxStyler()
  .color(Colors.red)
  .height(100)
  .width(100)
  .borderRounded(10)
  .onHovered(
    BoxStyler()
      .color(Colors.blue)
      .width(200)
  );

final styleB = styleA.onHovered(BoxStyler().color(Colors.green));
```

### Response
#### Success Response (200)
Returns the composed style, correctly merging variants.

#### Response Example
(Conceptual - final style when hovered)
```dart
// For styleB, when hovered:
BoxStyler()
  .color(Colors.green)
  .height(100)
  .width(200)
  .borderRounded(10);
```
```

--------------------------------

TITLE: Basic PressableBox Usage
DESCRIPTION: Demonstrates the basic usage of PressableBox, combining pressability with Box styling properties like color, padding, and border radius.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/pressable.mdx#_snippet_3

LANGUAGE: dart
CODE:
```
PressableBox(
  style: BoxStyler()
    .color(Colors.blue)
    .paddingAll(16)
    .borderRounded(8),
  onPress: () => print('PressableBox pressed'),
  child: StyledText('Styled Button'),
);
```

--------------------------------

TITLE: FlexStyler Core Methods
DESCRIPTION: Explains the core methods `resolve` for applying styles with context and `merge` for combining FlexStyler instances.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flex/flex_style_api.md#_snippet_21

LANGUAGE: dart
CODE:
```
resolve(BuildContext context) → StyleSpec<FlexSpec>
// Resolves all properties using the provided context, converting tokens and contextual values into concrete specifications.
merge(FlexStyler? other) → FlexStyler
// Merges this FlexStyler with another, with the other's properties taking precedence for non-null values.
```

--------------------------------

TITLE: Hero Section and Call-to-Action Stacks
DESCRIPTION: Illustrates the creation of hero sections with background images and call-to-action overlays. This includes `BoxDecoration` for images and `padding` for prominent button placements.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_util_api.md#_snippet_23

LANGUAGE: dart
CODE:
```
// Hero banner with centered content
final heroBanner = $stack
  .alignment.center()
  .fit.expand()
  .clipBehavior.hardEdge()
  .wrap.decoration(BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/hero_bg.jpg'),
      fit: BoxFit.cover,
    ),
  ));

// Call-to-action overlay
final ctaOverlay = $stack
  .alignment.bottomCenter()
  .fit.loose()
  .wrap.padding(EdgeInsets.all(24));
```

--------------------------------

TITLE: Run Flutter Tests
DESCRIPTION: Executes all flutter tests for the project using melos. Ensure tests pass after implementation changes.

SOURCE: https://github.com/btwld/mix/blob/main/mix_architecture_consolidation_plan.md#_snippet_27

LANGUAGE: bash
CODE:
```
melos run test:flutter
```

--------------------------------

TITLE: Access Design Tokens
DESCRIPTION: Demonstrates how to access previously defined design tokens, such as color and text style tokens, using the custom token instance.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/theming.mdx#_snippet_3

LANGUAGE: dart
CODE:
```
final primaryColorToken = $token.color.primary;
final headline1TextStyleToken = $token.textStyle.headline1;
```

--------------------------------

TITLE: BoxSpecUtility - Margin Configuration
DESCRIPTION: Provides comprehensive margin configuration for a box, mirroring the padding API.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_10

LANGUAGE: APIDOC
CODE:
```
## BoxSpecUtility - Margin

### Description
Configures margin for a box.

### Methods
- **all(double value)**: Sets margin on all sides.
- **only({double? left, double? top, double? right, double? bottom})**: Sets specific side margin.
- **horizontal(double value)**: Sets left and right margin.
- **vertical(double value)**: Sets top and bottom margin.
- **left(double value)**: Sets left margin.
- **right(double value)**: Sets right margin.
- **top(double value)**: Sets top margin.
- **bottom(double value)**: Sets bottom margin.

### Endpoint
`$box.margin`

### Parameters
#### Query Parameters
- **value** (double) - Required - Margin amount.
- **left, top, right, bottom** (double?) - Optional - Specific margin values for each side.
```

--------------------------------

TITLE: StackBoxSpecUtility Methods
DESCRIPTION: Details on utility methods provided by StackBoxSpecUtility for creating and accessing StackBoxStyler instances.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_19

LANGUAGE: APIDOC
CODE:
```
## StackBoxSpecUtility Methods

### StackBoxSpecUtility.self

Static access to StackBoxSpecUtility.

```dart
final utility = StackBoxSpecUtility.self;
```

### StackBoxSpecUtility.only({...}) → StackBoxStyler

Factory method for creating StackBoxStyler with specific properties.

```dart
StackBoxSpecUtility.only({
  // Box properties
  DecorationMix? decoration,
  EdgeInsetsGeometryMix? padding,
  EdgeInsetsGeometryMix? margin,
  BoxConstraintsMix? constraints,
  AlignmentGeometry? alignment,
  Matrix4? transform,
  AlignmentGeometry? transformAlignment,
  Clip? clipBehavior,
  // Stack properties
  AlignmentGeometry? stackAlignment,
  StackFit? fit,
  TextDirection? textDirection,
  Clip? stackClipBehavior,
  // Style properties
  List<VariantStyle<ZBoxSpec>>? variants,
})
```

### StackBoxSpecUtility.box → BoxStyler

Provides access to box styling utilities.

### StackBoxSpecUtility.stack → StackStyler

Provides access to stack styling utilities.
```

--------------------------------

TITLE: Configuring Image Fitting with ImageSpecUtility
DESCRIPTION: Shows how to define how an image fits within its bounds using various BoxFit options like contain, cover, fill, and scaleDown.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_util_api.md#_snippet_2

LANGUAGE: dart
CODE:
```
ImageSpecUtility image;

// Set box fit behavior
image.fit(BoxFit.contain);
image.fit.contain();
image.fit.cover();
image.fit.fill();
image.fit.fitWidth();
image.fit.fitHeight();
image.fit.scaleDown();
```

--------------------------------

TITLE: StackBoxStyler Instance Method: fit
DESCRIPTION: Illustrates the `fit` instance method for configuring how the stack's children are inscribed into the available space. It returns a modified StackBoxStyler.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_11

LANGUAGE: dart
CODE:
```
fit(StackFit value) → StackBoxStyler
```

--------------------------------

TITLE: ImageStyler Constructor
DESCRIPTION: The main constructor for ImageStyler allows direct instantiation with optional parameters for all image properties. This is used for creating a finalized image style object.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_0

LANGUAGE: dart
CODE:
```
ImageStyler({
  ImageProvider<Object>? image,
  double? width,
  double? height,
  Color? color,
  ImageRepeat? repeat,
  BoxFit? fit,
  AlignmentGeometry? alignment,
  Rect? centerSlice,
  FilterQuality? filterQuality,
  BlendMode? colorBlendMode,
  String? semanticLabel,
  bool? excludeFromSemantics,
  bool? gaplessPlayback,
  bool? isAntiAlias,
  bool? matchTextDirection,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<ImageSpec>>? variants,
})
```

--------------------------------

TITLE: Basic Stack Styling with $stack Utility
DESCRIPTION: Demonstrates creating basic stack layouts with different alignments and fit behaviors using the global '$stack' utility. This includes centered, expanded, and clipped stacks.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_style_api.md#_snippet_21

LANGUAGE: dart
CODE:
```
final centeredStack = $stack
  .alignment.center()
  .fit.loose();

// Expanded stack with top-left alignment
final expandedStack = $stack
  .alignment.topLeft()
  .fit.expand();

// Stack with clipping
final clippedStack = $stack
  .alignment.center()
  .fit.expand()
  .clipBehavior.hardEdge();
```

--------------------------------

TITLE: Dart: Creating Text Widgets
DESCRIPTION: Shows different ways to create text widgets using Dart. This includes using a `Style.text()` factory method, directly instantiating a `StyledText` widget, and utilizing the call operator on a style object.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_63

LANGUAGE: dart
CODE:
```
// Using Style.text() factory (common pattern)
final widget = Style.text(
  fontSize: 16,
  color: Colors.blue,
  fontWeight: FontWeight.bold,
)('Hello World');

// Using StyledText widget directly
final widget = StyledText('Hello World', style: textStyle);

// Using call operator on style
final widget = textStyle('Hello World');
```

--------------------------------

TITLE: Testing Commands After Phase 3 (Box)
DESCRIPTION: These commands execute tests for the Box module after Phase 3 of the project refactoring, which involved significant changes to the box system.

SOURCE: https://github.com/btwld/mix/blob/main/mix_architecture_consolidation_plan.md#_snippet_24

LANGUAGE: bash
CODE:
```
# After Phase 3 (Box):
melos exec --scope="mix" -- flutter test test/src/specs/box/
```

--------------------------------

TITLE: Controlling Image Dimensions with ImageSpecUtility
DESCRIPTION: Illustrates how to set and control the width and height of an image using the ImageSpecUtility, including fixed sizes, filling available space, and wrapping to content.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_util_api.md#_snippet_1

LANGUAGE: dart
CODE:
```
ImageSpecUtility image;

// Set image width
image.width(200.0);
image.width.fixed(150.0);
image.width.fill();
image.width.wrap();

// Set image height
image.height(100.0);
image.height.fixed(80.0);
image.height.fill();
image.height.wrap();
```

--------------------------------

TITLE: Advanced Stack Configurations
DESCRIPTION: Demonstrates advanced stack styling techniques, including multi-layered UI with custom animations, responsive stacks adapting to text direction, and performance-optimized clipping.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_style_api.md#_snippet_25

LANGUAGE: dart
CODE:
```
// Multi-layered UI with different alignments
final complexStack = $stack
  .fit.expand()
  .clipBehavior.antiAliasWithSaveLayer()
  .animate(AnimationConfig(
    duration: Duration(milliseconds: 500),
    curve: Curves.elasticOut,
  ));

// Responsive stack that adapts to text direction
final responsiveStack = $stack
  .alignment.centerLeft()
  .textDirection.ltr()  // Can be dynamically changed
  .fit.loose();

// Stack with strict clipping for performance
final performanceStack = $stack
  .alignment.center()
  .fit.expand()
  .clipBehavior.hardEdge();  // Most performant clipping
```

--------------------------------

TITLE: BoxStyler Core Methods
DESCRIPTION: Core methods for widget creation, style resolution, and merging.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_13

LANGUAGE: APIDOC
CODE:
```
## BoxStyler Core Methods

### call({Widget? child}) → Box
Creates a `Box` widget with this style applied. This is the primary method for converting a style into a widget.

### resolve(BuildContext context) → StyleSpec<BoxSpec>
Resolves all properties using the provided context, converting tokens and contextual values into concrete specifications.

### merge(BoxStyler? other) → BoxStyler
Merges this BoxStyler with another, with the other's properties taking precedence for non-null values.
```

--------------------------------

TITLE: TextStyler: Applying Basic Styles
DESCRIPTION: Demonstrates how to use the TextStyler's fluent API to apply common text styling properties like color, font size, font weight, text alignment, max lines, and text overflow.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_59

LANGUAGE: dart
CODE:
```
final style = $text
  .color.blue()
  .fontSize(16)
  .bold()
  .textAlign(TextAlign.center)
  .maxLines(2)
  .textOverflow(TextOverflow.ellipsis);
```

--------------------------------

TITLE: BoxSpecUtility - Decoration Configuration
DESCRIPTION: Configures the box decoration, including direct setting of a Decoration object or access to BoxDecoration utilities.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_12

LANGUAGE: APIDOC
CODE:
```
## BoxSpecUtility - Decoration

### Description
Configures the decoration for the box.

### Methods
- **decoration(Decoration value)**: Sets the decoration directly.
- **decoration.box**: Accesses BoxDecoration utilities for specific box decoration properties.

### Endpoint
`$box.decoration`

### Parameters
#### Request Body
- **value** (Decoration) - Required - The Decoration object to apply.
```

--------------------------------

TITLE: Accessing StackBoxSpecUtility and its Components
DESCRIPTION: Demonstrates how to access the StackBoxSpecUtility and its individual box and stack utilities for styling purposes. This utility class provides access to pre-defined styling configurations.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_0

LANGUAGE: dart
CODE:
```
final utility = StackBoxSpecUtility.self;
final boxUtility = utility.box;
final stackUtility = utility.stack;
```

--------------------------------

TITLE: BoxStyler Constructors
DESCRIPTION: Details the various constructors available for creating BoxStyler instances.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_11

LANGUAGE: APIDOC
CODE:
```
## BoxStyler Constructors

### BoxStyler({...}) → BoxStyler
Main constructor with optional parameters for all box properties.

```dart
BoxStyler({
  AlignmentGeometry? alignment,
  EdgeInsetsGeometryMix? padding,
  EdgeInsetsGeometryMix? margin,
  BoxConstraintsMix? constraints,
  DecorationMix? decoration,
  DecorationMix? foregroundDecoration,
  Matrix4? transform,
  AlignmentGeometry? transformAlignment,
  Clip? clipBehavior,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<BoxSpec>>? variants,
})
```

### BoxStyler.create({...}) → BoxStyler
Internal constructor using `Prop<T>` types for advanced usage.

```dart
const BoxStyler.create({
  Prop<AlignmentGeometry>? alignment,
  Prop<EdgeInsetsGeometry>? padding,
  Prop<EdgeInsetsGeometry>? margin,
  Prop<BoxConstraints>? constraints,
  Prop<Decoration>? decoration,
  Prop<Decoration>? foregroundDecoration,
  Prop<Matrix4>? transform,
  Prop<AlignmentGeometry>? transformAlignment,
  Prop<Clip>? clipBehavior,
  List<VariantStyle<BoxSpec>>? variants,
  ModifierConfig? modifier,
  AnimationConfig? animation,
})
```

### BoxStyler.builder(BoxStyler Function(BuildContext)) → BoxStyler
Factory constructor for context-dependent styling.
```

--------------------------------

TITLE: StackBoxStyler Instance Methods
DESCRIPTION: Instance methods for manipulating StackBoxStyler properties.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_21

LANGUAGE: APIDOC
CODE:
```
## StackBoxStyler Instance Methods

### Direct Methods

- **variants(List<VariantStyle<ZBoxSpec>> variants)** → StackBoxStyler - Sets conditional styling variants

### Stack-Specific Methods

- **stackAlignment(AlignmentGeometry value)** → StackBoxStyler - Sets stack alignment
- **fit(StackFit value)** → StackBoxStyler - Sets stack fit behavior
- **textDirection(TextDirection value)** → StackBoxStyler - Sets text direction
- **stackClipBehavior(Clip value)** → StackBoxStyler - Sets stack clip behavior

### Box-Specific Methods

- **alignment(AlignmentGeometry value)** → StackBoxStyler - Sets box alignment
- **transformAlignment(AlignmentGeometry value)** → StackBoxStyler - Sets transform alignment
- **clipBehavior(Clip value)** → StackBoxStyler - Sets box clip behavior
- **foregroundDecoration(DecorationMix value)** → StackBoxStyler - Sets foreground decoration

### Spacing Methods (from SpacingStyleMixin)

(Methods for spacing manipulation are available via the SpacingStyleMixin, refer to its documentation for details.)
```

--------------------------------

TITLE: Style custom widget with Mix in Flutter
DESCRIPTION: Demonstrates styling a custom widget using the Mix library, including text and box decorations with hover effects and animations. This approach simplifies complex styling and interaction handling.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/comparison.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
class CustomMixWidget extends StatelessWidget {
  const CustomMixWidget({super.key});

  TextStyler get customTextStyle {
    return TextStyler()
        .fontSize(16)
        .fontWeight(FontWeight.w600)
        .color(Colors.white)
        .animate(AnimationConfig.easeInOut(100.ms))
        .onDark(TextStyler().color(Colors.black))
        .onHovered(
          TextStyler()
              .animate(AnimationConfig.easeInOut(100.ms))
              .onLight(TextStyler().color(Colors.white)),
        );
  }

  BoxStyler get customBoxStyle {
    return BoxStyler()
        .height(120)
        .width(120)
        .paddingAll(20)
        .elevation(ElevationShadow.nine)
        .alignment(Alignment.center)
        .borderRounded(10)
        .color(Colors.blue)
        .scale(1.0)
        .animate(AnimationConfig.easeInOut(100.ms))
        .onDark(BoxStyler().color(Colors.cyan))
        .onHovered(
          BoxStyler()
              .alignment(Alignment.topLeft)
              .elevation(ElevationShadow.two)
              .paddingAll(10)
              .scale(1.5)
              .animate(AnimationConfig.easeInOut(100.ms))
              .onLight(BoxStyler().color(Colors.blue.shade300)),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onPress: () {},
      child: Box(
        style: customBoxStyle,
        child: StyledText('Custom Widget', style: customTextStyle),
      ),
    );
  }
}
```

--------------------------------

TITLE: TextStyler Constructor - Dart
DESCRIPTION: The main constructor for the TextStyler class allows for direct instantiation with optional parameters for all text properties. It provides a way to create a finalized text style.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_0

LANGUAGE: dart
CODE:
```
TextStyler({
  TextOverflow? overflow,
  StrutStyleMix? strutStyle,
  TextAlign? textAlign,
  TextScaler? textScaler,
  int? maxLines,
  TextStyleMix? style,
  TextWidthBasis? textWidthBasis,
  TextHeightBehaviorMix? textHeightBehavior,
  TextDirection? textDirection,
  bool? softWrap,
  List<Directive<String>>? textDirectives,
  Color? selectionColor,
  String? semanticsLabel,
  Locale? locale,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<TextSpec>>? variants,
})
```

--------------------------------

TITLE: TextStyler: Constructor with TextStyleMix
DESCRIPTION: Shows how to instantiate and configure TextStyler using its constructor, applying styles directly via TextStyleMix and then chaining other modifiers like text alignment, max lines, overflow, and animation.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_61

LANGUAGE: dart
CODE:
```
final textStyle = TextStyler()
  .style(TextStyleMix(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ))
  .textAlign(TextAlign.center)
  .maxLines(2)
  .overflow(TextOverflow.ellipsis)
  .uppercase()
  .animate(AnimationConfig(duration: Duration(milliseconds: 200)));
```

--------------------------------

TITLE: BoxSpecUtility - Variant Support
DESCRIPTION: Provides methods for applying styles based on variants.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_16

LANGUAGE: APIDOC
CODE:
```
## BoxSpecUtility - Variant Support

### Description
Applies styles conditionally based on variants.

### Methods
- **withVariant(Variant variant, BoxStyler style)**: Applies a style under a specific variant condition.
- **withVariants(List<VariantStyle<BoxSpec>> variants)**: Applies multiple variant styles.

### Endpoint
`$box`

### Parameters
#### Request Body
- **variant** (Variant) - Required for `withVariant` - The variant condition.
- **style** (BoxStyler) - Required for `withVariant` - The style to apply for the variant.
- **variants** (List<VariantStyle<BoxSpec>>) - Required for `withVariants` - A list of variant styles.
```

--------------------------------

TITLE: Image Source and Content
DESCRIPTION: Methods for controlling the image source, including setting from various providers like assets, network URLs, files, or memory.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_util_api.md#_snippet_6

LANGUAGE: APIDOC
CODE:
```
## Image Source & Content

### `$image.image` → MixUtility

Controls the image source.

- **`$image.image(ImageProvider value)`** → ImageStyler - Sets image provider
- **`$image.image.asset(String path)`** → ImageStyler - Sets asset image
- **`$image.image.network(String url)`** → ImageStyler - Sets network image
- **`$image.image.file(File file)`** → ImageStyler - Sets file image
- **`$image.image.memory(Uint8List bytes)`** → ImageStyler - Sets memory image
```

--------------------------------

TITLE: StackBoxStyler Main Constructor
DESCRIPTION: Defines the main constructor for StackBoxStyler, accepting optional parameters for various box and stack properties. This allows for the creation of a fully configured stack-box style in one step.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_2

LANGUAGE: dart
CODE:
```
StackBoxStyler({
  // Box properties
  DecorationMix? decoration,
  DecorationMix? foregroundDecoration,
  EdgeInsetsGeometryMix? padding,
  EdgeInsetsGeometryMix? margin,
  AlignmentGeometry? alignment,
  BoxConstraintsMix? constraints,
  Matrix4? transform,
  AlignmentGeometry? transformAlignment,
  Clip? clipBehavior,
  // Stack properties
  AlignmentGeometry? stackAlignment,
  StackFit? fit,
  TextDirection? textDirection,
  Clip? stackClipBehavior,
  // Style properties
  List<VariantStyle<ZBoxSpec>>? variants,
})
```

--------------------------------

TITLE: Define Custom Theme Tokens
DESCRIPTION: Shows how to define a comprehensive set of custom design tokens for colors and text styles within a theme. This includes creating nested token categories for better organization and accessibility.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/theming.mdx#_snippet_2

LANGUAGE: dart
CODE:
```
const $token = MyThemeToken();

class MyThemeToken {
  const MyThemeToken();

  final color = const MyThemeColorToken();
  final textStyle = const MyThemeTextStyleToken();
}

class MyThemeColorToken {
  const MyThemeColorToken();

  ColorToken get primary => const ColorToken('primary-color');
  ColorToken get onPrimary => const ColorToken('on-primary-color');
  ColorToken get surface => const ColorToken('surface-color');
  ColorToken get onSurface => const ColorToken('on-surface-color');
  ColorToken get onSurfaceVariant =>
      const ColorToken('on-surface-variant-color');
}

class MyThemeTextStyleToken {
  const MyThemeTextStyleToken();

  TextStyleToken get headline1 => const TextStyleToken('headline1');
  TextStyleToken get headline2 => const TextStyleToken('headline2');
  TextStyleToken get headline3 => const TextStyleToken('headline3');
  TextStyleToken get body => const TextStyleToken('body');
  TextStyleToken get callout => const TextStyleToken('callout');
}
```

--------------------------------

TITLE: IconStyler Constructor
DESCRIPTION: The main constructor for the IconStyler class, allowing optional parameters for all icon properties. This is used for direct instantiation of an icon style.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_style_api.md#_snippet_0

LANGUAGE: dart
CODE:
```
IconStyler({
  Color? color,
  double? size,
  double? weight,
  double? grade,
  double? opticalSize,
  List<ShadowMix>? shadows,
  TextDirection? textDirection,
  bool? applyTextScaling,
  double? fill,
  String? semanticsLabel,
  double? opacity,
  BlendMode? blendMode,
  IconData? icon,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<IconSpec>>? variants,
})
```

--------------------------------

TITLE: FlexStyler Constructor
DESCRIPTION: The main constructor for the FlexStyler class, allowing initialization with various flex properties.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flex/flex_style_api.md#_snippet_18

LANGUAGE: APIDOC
CODE:
```
## FlexStyler({...}) → FlexStyler

### Description
Main constructor with optional parameters for all flex properties.

### Method
POST

### Endpoint
/flexstyler

### Request Body
- **direction** (Axis) - Optional - The direction of the flex layout.
- **mainAxisAlignment** (MainAxisAlignment) - Optional - Alignment along the main axis.
- **crossAxisAlignment** (CrossAxisAlignment) - Optional - Alignment along the cross axis.
- **mainAxisSize** (MainAxisSize) - Optional - The size of the flex layout along the main axis.
- **verticalDirection** (VerticalDirection) - Optional - The direction of children in a vertical flex layout.
- **textDirection** (TextDirection) - Optional - The direction of text (left-to-right or right-to-left).
- **textBaseline** (TextBaseline) - Optional - The text baseline for alignment.
- **clipBehavior** (Clip) - Optional - How the flex layout clips its children.
- **spacing** (double) - Optional - Spacing between children.
- **animation** (AnimationConfig) - Optional - Animation configuration.
- **modifier** (ModifierConfig) - Optional - Modifier configuration.
- **variants** (List<VariantStyle<FlexSpec>>) - Optional - List of variant styles.

### Request Example
```json
{
  "direction": "horizontal",
  "mainAxisAlignment": "center",
  "crossAxisAlignment": "stretch",
  "spacing": 10.0,
  "animation": {
    "duration": 500,
    "curve": "easeIn"
  }
}
```

### Response
#### Success Response (200)
- **flexStylerInstance** (object) - A FlexStyler instance with the specified properties.

#### Response Example
```json
{
  "flexStylerInstance": {
    "direction": "horizontal",
    "mainAxisAlignment": "center",
    "crossAxisAlignment": "stretch",
    "mainAxisSize": "max",
    "verticalDirection": "down",
    "textDirection": "ltr",
    "textBaseline": "alphabetic",
    "clipBehavior": "none",
    "spacing": 10.0,
    "animation": {
      "duration": 500,
      "curve": "easeIn"
    }
  }
}
```
```

--------------------------------

TITLE: Utility Instance Creation
DESCRIPTION: Illustrates that each global utility accessor, like `$box`, creates a new instance every time it is invoked, highlighting the non-singleton nature of these accessors.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/spec_util_api.md#_snippet_15

LANGUAGE: dart
CODE:
```
final utility1 = $box;  // New BoxSpecUtility instance
final utility2 = $box;  // Different BoxSpecUtility instance
```

--------------------------------

TITLE: IconStyler Core Method: resolve
DESCRIPTION: Resolves all properties of the IconStyler using the provided `BuildContext`. This method converts tokens and contextual values into concrete specifications for styling.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_style_api.md#_snippet_5

LANGUAGE: dart
CODE:
```
resolve(BuildContext context)
```

--------------------------------

TITLE: StackStyler Core Methods
DESCRIPTION: Core methods for resolving and merging StackStyler configurations.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_style_api.md#_snippet_15

LANGUAGE: APIDOC
CODE:
```
## Core Methods

### resolve(BuildContext context) → StyleSpec<StackSpec>
Resolves all properties using the provided context, converting tokens and contextual values into concrete specifications.

### merge(StackStyler? other) → StackStyler
Merges this StackStyler with another, with the other's properties taking precedence for non-null values.
```

--------------------------------

TITLE: BoxSpecUtility - Convenience Accessors
DESCRIPTION: Provides direct access to common styling properties like border, color, size, and alignment.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_14

LANGUAGE: APIDOC
CODE:
```
## BoxSpecUtility - Convenience Accessors

### Description
Direct access to common styling properties.

### Accessors
- **$box.border**: Accesses border styling utilities.
- **$box.borderRadius**: Accesses border radius styling utilities.
- **$box.color**: Accesses background color styling utilities.
- **$box.gradient**: Accesses gradient background styling utilities.
- **$box.shape**: Accesses shape configuration utilities.
- **$box.shadow**: Accesses box shadow styling utilities.
- **$box.width**: Sets width constraints.
- **$box.height**: Sets height constraints.
- **$box.minWidth**: Sets minimum width constraints.
- **$box.maxWidth**: Sets maximum width constraints.
- **$box.minHeight**: Sets minimum height constraints.
- **$box.maxHeight**: Sets maximum height constraints.
- **$box.transform**: Accesses transform matrix utilities.
- **$box.clipBehavior**: Accesses clipping behavior settings.
- **$box.alignment**: Accesses alignment settings.
```

--------------------------------

TITLE: Visual Effects
DESCRIPTION: Methods for applying color overlays and blend modes.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_16

LANGUAGE: APIDOC
CODE:
```
## Visual Effects

#### $image.color → ColorUtility
Provides color overlay configuration:
- **$image.color(Color)** → Sets color overlay directly
- **$image.color.red()**, **$image.color.blue()**, etc. → Named color shortcuts
- **$image.color.withOpacity(0.5)** → Color with opacity
- **$image.color.black26()**, **$image.color.white70()** → Opacity variants

#### $image.colorBlendMode → MixUtility
Provides blend mode configuration:
- **$image.colorBlendMode(BlendMode)** → Sets how color blends with image
- **$image.colorBlendMode.multiply()**, **$image.colorBlendMode.overlay()** → Blend mode shortcuts
```

--------------------------------

TITLE: IconStyler Methods
DESCRIPTION: Core methods for manipulating and resolving IconStyler instances, including creating a StyledIcon, resolving styles with context, and merging styles.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_style_api.md#_snippet_16

LANGUAGE: APIDOC
CODE:
```
## Core Methods

### call({IconData? icon, String? semanticLabel}) → StyledIcon
Creates a `StyledIcon` widget with optional icon data and semantic label, using this style.

### resolve(BuildContext context) → StyleSpec<IconSpec>
Resolves all properties using the provided context, converting tokens and contextual values into concrete specifications.

### merge(IconStyler? other) → IconStyler
Merges this IconStyler with another, with the other's properties taking precedence for non-null values.
```

--------------------------------

TITLE: Add Mix to Flutter Project (CLI)
DESCRIPTION: This command demonstrates adding the Mix package to a Flutter project using the Flutter CLI. It ensures the specified version of Mix is included in your project's dependencies.

SOURCE: https://github.com/btwld/mix/blob/main/README.md#_snippet_1

LANGUAGE: bash
CODE:
```
flutter pub add mix:^2.0.0-dev.1
```

--------------------------------

TITLE: Mix Padding Utilities (Dart)
DESCRIPTION: Demonstrates how to apply padding to elements using Mix's utility-first approach in Dart. It shows single-value padding, directional padding, and horizontal padding. This requires the Mix styling utilities to be available.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/README.md#_snippet_3

LANGUAGE: dart
CODE:
```
$box.padding(20); /// Padding 20 on all sides
$box.padding(20, 10); /// Padding 20 on top and bottom, 10 on left and right

$box.padding.top(20); /// Padding 20 on top
$box.padding.horizontal(20); /// Padding 20 on left and right
```

--------------------------------

TITLE: StyledImage Widget Usage (Dart)
DESCRIPTION: Demonstrates how to use the StyledImage widget with an AssetImage and apply styling using ImageStyler for width, height, and BoxFit.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/image.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
StyledImage(
  image: AssetImage('assets/image.jpg'),
  style: ImageStyler()
      .width(152)
      .height(152)
      .fit(BoxFit.cover),
);
```

--------------------------------

TITLE: Deprecated Global Utilities vs. New Spec-Specific Utilities
DESCRIPTION: Demonstrates the shift from deprecated global `$on` and `$wrap` utilities to the recommended spec-specific utilities for event handling and styling composition. The new pattern offers improved type safety and a more intuitive API.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/spec_util_api.md#_snippet_14

LANGUAGE: dart
CODE:
```
// Old Pattern (Deprecated)
// Don't use these patterns
$on.hover($box.color.red(), $text.color.white())
$wrap.opacity(0.5, $box.padding.all(16))
```

LANGUAGE: dart
CODE:
```
// New Pattern (Recommended)
// Use spec-specific utilities instead
$box.color.blue().onHovered($box.color.red())
$text.color.black().onHovered($text.color.white())
$box.padding.all(16).wrap.opacity(0.5)
```

--------------------------------

TITLE: Migration from Deprecated Global Utilities
DESCRIPTION: Provides a direct comparison for migrating from the old, deprecated global utility syntax to the new, recommended spec-specific utility syntax.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/spec_util_api.md#_snippet_25

LANGUAGE: dart
CODE:
```
// Old (deprecated)
$on.hover($box.color.red(), $text.color.white())

// New (recommended)
$box.color.blue().onHovered($box.color.red())
$text.color.black().onHovered($text.color.white())
```

--------------------------------

TITLE: Combining Individual Styling Utilities
DESCRIPTION: Shows how to combine individual styling utilities from global factories like `$box` and `$stack` to create complex styles, which can then be applied to a StackBoxStyler. This approach enhances reusability and readability for intricate designs.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_39

LANGUAGE: dart
CODE:
```
// Leverage existing global utilities
final backgroundStyle = $box
  .color.gradient.linear(
    colors: [Colors.purple.shade400, Colors.blue.shade400],
  )
  .borderRadius(16)
  .padding.all(24);

final stackBehavior = $stack
  .alignment.center()
  .fit.expand();

// Combine in StackBoxStyler
final combinedStyle = StackBoxStyler(
  decoration: backgroundStyle.$decoration?.resolve(context),
  padding: backgroundStyle.$padding?.resolve(context),
  stackAlignment: Alignment.center,
  fit: StackFit.expand,
);
```

--------------------------------

TITLE: Background Image Methods for StackBoxStyler
DESCRIPTION: Methods for setting background images on a StackBox, supporting ImageProvider, URLs, and assets. Options for fit, alignment, and repeat are available.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_27

LANGUAGE: dart
CODE:
```
StackBoxStyler().backgroundImage(ImageProvider image, {BoxFit? fit, AlignmentGeometry? alignment, ImageRepeat repeat});
StackBoxStyler().backgroundImageUrl(String url, {BoxFit? fit, AlignmentGeometry? alignment, ImageRepeat repeat});
StackBoxStyler().backgroundImageAsset(String path, {BoxFit? fit, AlignmentGeometry? alignment, ImageRepeat repeat});
```

--------------------------------

TITLE: Stack Styling using StackStyler Constructor
DESCRIPTION: Illustrates how to initialize and configure a StackStyler object directly to define stack properties such as alignment, fit, clipping, and animation.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_style_api.md#_snippet_23

LANGUAGE: dart
CODE:
```
final stackStyle = StackStyler()
  .alignment(Alignment.center)
  .fit(StackFit.expand)
  .clipBehavior(Clip.hardEdge)
  .animate(AnimationConfig(duration: Duration(milliseconds: 200)));
```

--------------------------------

TITLE: BoxStyler Instance Methods - Constraints
DESCRIPTION: Methods for setting box constraints.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_16

LANGUAGE: APIDOC
CODE:
```
## BoxStyler Instance Methods - Constraints

### Base Method
- **constraints(BoxConstraintsMix value)** → BoxStyler - Sets box constraints
```

--------------------------------

TITLE: Creating Widgets with BoxStyler in Dart
DESCRIPTION: Demonstrates multiple ways to create widgets using BoxStyler, including the `Style.box()` factory, direct `Box` widget usage, and invoking the style object like a function.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_64

LANGUAGE: dart
CODE:
```
final widget = Style.box(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
)(child: Text('Hello'));

final widget = Box(style: boxStyle, child: Text('Hello'));

final widget = boxStyle(child: Text('Hello'));
```

--------------------------------

TITLE: TextStyler Core Methods
DESCRIPTION: Core methods for creating, resolving, and merging text styles.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_45

LANGUAGE: APIDOC
CODE:
```
## Core Methods

### call(String text) → StyledText
Creates a `StyledText` widget with the provided text and this style applied.

### resolve(BuildContext context) → StyleSpec<TextSpec>
Resolves all properties using the provided context, converting tokens and contextual values into concrete specifications.

### merge(TextStyler? other) → TextStyler
Merges this TextStyler with another, with the other's properties taking precedence for non-null values.
```

--------------------------------

TITLE: Dart Flex Layouts using Global Utility
DESCRIPTION: Defines various row and column layouts using a global flex utility. Includes configurations for alignment, spacing, and animation. Requires the Mix framework.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flex/flex_style_api.md#_snippet_39

LANGUAGE: dart
CODE:
```
final rowLayout = $flex
  .row()
  .mainAxisAlignment.spaceBetween()
  .crossAxisAlignment.center()
  .spacing(16);
```

LANGUAGE: dart
CODE:
```
final columnLayout = $flex
  .column()
  .mainAxisAlignment.start()
  .crossAxisAlignment.stretch()
  .spacing(8);
```

LANGUAGE: dart
CODE:
```
final centeredLayout = $flex
  .column()
  .mainAxisAlignment.center()
  .crossAxisAlignment.center()
  .mainAxisSize.max()
  .spacing(12);
```

LANGUAGE: dart
CODE:
```
final responsiveLayout = $flex
  .row()
  .mainAxisAlignment.spaceEvenly()
  .crossAxisAlignment.baseline()
  .textBaseline.alphabetic()
  .spacing(20)
  .animate(AnimationConfig(duration: Duration(milliseconds: 300)));
```

--------------------------------

TITLE: BoxSpecUtility - Decoration Configuration
DESCRIPTION: Configures the decoration of a box, which can include background colors, gradients, borders, and shadows. It can set decoration directly or access Box Decoration Utilities.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_3

LANGUAGE: dart
CODE:
```
/// Sets decoration directly
$box.decoration(BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8.0)))

/// Accesses box decoration utilities for more granular control
$box.decoration.box
```

--------------------------------

TITLE: Utility Methods (via $icon)
DESCRIPTION: Provides access to utility classes for configuring various aspects of icon styling, including color, shadows, size, typography, layout, modifiers, and animation.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_style_api.md#_snippet_19

LANGUAGE: APIDOC
CODE:
```
## Utility Methods (via $icon)

### Visual Properties
#### $icon.color → ColorUtility
Provides comprehensive color configuration:
- **$icon.color(Color)** → Sets icon color directly
- **$icon.color.red()**, **$icon.color.blue()**, etc. → Named color shortcuts
- **$icon.color.red.shade500()** → Material color shades
- **$icon.color.withOpacity(0.5)** → Color with opacity
- **$icon.color.black87()**, **$icon.color.white70()** → Opacity variants

### Shadow Effects
#### $icon.shadow → ShadowUtility  
Provides shadow configuration:
- **$icon.shadow(ShadowMix)** → Adds a single shadow effect
- **$icon.shadow.small()**, **$icon.shadow.medium()**, **$icon.shadow.large()** → Preset shadows
- **$icon.shadows(List<ShadowMix>)** → Adds multiple shadow effects

### Size & Typography
- **$icon.size(double)** → Sets icon size in logical pixels
- **$icon.weight(double)** → Sets icon weight/thickness for variable fonts
- **$icon.grade(double)** → Sets icon grade for variable fonts
- **$icon.opticalSize(double)** → Sets optical size adjustment for variable fonts
- **$icon.fill(double)** → Sets fill amount for filled/outlined icons (0.0 to 1.0)

### Layout & Direction
- **$icon.textDirection** → MixUtility for TextDirection settings
- **$icon.applyTextScaling(bool)** → Sets whether icon scales with text scale factor

### Modifiers & Animation
- **$icon.wrap** → ModifierUtility for widget modifiers
- **$icon.animate(AnimationConfig)** → Applies animation configuration
```

--------------------------------

TITLE: FlexBoxSpecUtility - Gradient
DESCRIPTION: Provides direct access to gradient background configuration.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flexbox/flexbox_util_api.md#_snippet_16

LANGUAGE: APIDOC
CODE:
```
## Set Gradient Background

### Description
Sets the gradient background for the flexbox layout.

### Method
POST

### Endpoint
/flexbox/gradient

### Parameters
#### Request Body
- **value** (Gradient) - Required - The gradient to apply.

### Request Example
```json
{
  "value": {
    "type": "LinearGradient",
    "colors": ["#FF0000", "#0000FF"],
    "begin": "Alignment.topLeft",
    "end": "Alignment.bottomRight"
  }
}
```

### Response
#### Success Response (200)
- **message** (string) - Confirmation of gradient configuration.

#### Response Example
```json
{
  "message": "Gradient background applied successfully."
}
```
```

--------------------------------

TITLE: Repeated and Nine-Patch Image Layouts in Dart
DESCRIPTION: Demonstrates creating a repeating pattern image and a nine-patch style image using Dart's ImageSpecUtility. The repeated pattern image uses `repeat()` to tile the asset, while the nine-patch image uses `centerSlice()` for scalable UI elements.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_util_api.md#_snippet_14

LANGUAGE: dart
CODE:
```
final patternImage = $image
  .image.asset('assets/pattern.png')
  .repeat.repeat()
  .width(double.infinity)
  .height(200)
  .fit.none();

final ninePatchImage = $image
  .image.asset('assets/button_bg.png')
  .centerSlice(Rect.fromLTRB(10, 10, 90, 90))
  .width(200)
  .height(60)
  .fit.fill();
```

--------------------------------

TITLE: Image Effects and Colors
DESCRIPTION: Methods for applying color tints and controlling color blending modes for the image.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_util_api.md#_snippet_10

LANGUAGE: APIDOC
CODE:
```
## Image Effects & Colors

### `$image.color` → ColorUtility

Controls image color tinting.

- **`$image.color(Color value)`** → ImageStyler - Sets color tint
- **`$image.color.red()`** → ImageStyler - Applies red tint
- **`$image.color.green()`** → ImageStyler - Applies green tint
- **`$image.color.blue()`** → ImageStyler - Applies blue tint
- **`$image.color.white()`** → ImageStyler - Applies white tint
- **`$image.color.black()`** → ImageStyler - Applies black tint
- **`$image.color.transparent()`** → ImageStyler - Makes transparent

### `$image.colorBlendMode` → BlendModeUtility

Controls color blending with the image.

- **`$image.colorBlendMode(BlendMode value)`** → ImageStyler - Sets blend mode
- **`$image.colorBlendMode.normal()`** → ImageStyler - Normal blending
- **`$image.colorBlendMode.multiply()`** → ImageStyler - Multiply blending
- **`$image.colorBlendMode.screen()`** → ImageStyler - Screen blending
- **`$image.colorBlendMode.overlay()`** → ImageStyler - Overlay blending
- **`$image.colorBlendMode.softLight()`** → ImageStyler - Soft light blending
- **`$image.colorBlendMode.hardLight()`** → ImageStyler - Hard light blending
```

--------------------------------

TITLE: Create Flutter ProfilePage Widget
DESCRIPTION: Defines a stateless Flutter widget for a profile page, utilizing Mix design tokens for styling UI elements like AppBar, text, and images. It demonstrates how to resolve token values for Flutter widget properties.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/theming.md#_snippet_1

LANGUAGE: dart
CODE:
```
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: $token.color.surface.resolve(context),
        title: Text(
          'Profile',
          style: $token.textStyle.headline2.resolve(context).copyWith(
                color: $token.color.onSurface.resolve(context),
              ),
        ),
      ),
      backgroundColor: $token.color.surface.resolve(context),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                $token.radius.medium.resolve(context),
              ),
              child: Image.network(
                'https://placehold.co/358x292@2x.png',
              ),
            ),
            SizedBox(height: $token.space.large.resolve(context)),
            Text(
              'Hollywood Academy',
              style: $token.textStyle.headline1.resolve(context).copyWith(
                    color: $token.color.onSurface.resolve(context),
                  ),
            ),
            SizedBox(height: $token.space.medium.resolve(context)),
            Text(
              'Education · Los Angeles, California',
              style: $token.textStyle.callout.resolve(context).copyWith(
                    color: $token.color.onSurfaceVariant.resolve(context),
                  ),
            ),
            SizedBox(height: $token.space.medium.resolve(context)),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry`s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              style: $token.textStyle.body.resolve(context).copyWith(
                    color: $token.color.onSurfaceVariant.resolve(context),
                  ),
            ),
            const Spacer(),
            const ProfileButton(
              label: 'Add to your contacts',
            ),
          ],
        ),
      ),
    );
  }
}
```

--------------------------------

TITLE: TextStyler Factory Constructor - Dart
DESCRIPTION: A factory constructor for TextStyler that facilitates context-dependent text styling by accepting a function that takes a BuildContext.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_2

LANGUAGE: dart
CODE:
```
TextStyler.builder(TextStyler Function(BuildContext))
```

--------------------------------

TITLE: Dart Common Flex Layout Patterns
DESCRIPTION: Illustrates common UI layout patterns using the flex utility. Includes navigation bars, card content, button groups, form fields, grid-like structures, and toolbars. Assumes Mix framework.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flex/flex_style_api.md#_snippet_41

LANGUAGE: dart
CODE:
```
final navbar = $flex
  .row()
  .mainAxisAlignment.spaceBetween()
  .crossAxisAlignment.center()
  .spacing(16);
```

LANGUAGE: dart
CODE:
```
final cardContent = $flex
  .column()
  .crossAxisAlignment.start()
  .spacing(12);
```

LANGUAGE: dart
CODE:
```
final buttonGroup = $flex
  .row()
  .mainAxisAlignment.end()
  .spacing(8);
```

LANGUAGE: dart
CODE:
```
final formLayout = $flex
  .column()
  .crossAxisAlignment.stretch()
  .spacing(16);
```

LANGUAGE: dart
CODE:
```
final gridLayout = $flex
  .row()
  .mainAxisAlignment.spaceEvenly()
  .crossAxisAlignment.start()
  .spacing(12);
```

LANGUAGE: dart
CODE:
```
final toolbar = $flex
  .row()
  .mainAxisAlignment.spaceBetween()
  .crossAxisAlignment.center()
  .mainAxisSize.max()
  .spacing(8);
```

--------------------------------

TITLE: StackBoxSpecUtility Factory Usage
DESCRIPTION: Illustrates using the StackBoxSpecUtility factory to create styled containers. This method allows for a more concise way to apply specific styling properties like decoration, padding, border-radius, and alignment.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_38

LANGUAGE: dart
CODE:
```
// Using the utility factory
final utility = StackBoxSpecUtility.self;

final styledContainer = utility.only(
  decoration: DecorationMix.color(Colors.grey.shade100),
  padding: EdgeInsetsGeometryMix.all(20),
  borderRadius: BorderRadiusGeometryMix.circular(16),
  stackAlignment: Alignment.bottomCenter,
  fit: StackFit.expand,
);
```

--------------------------------

TITLE: Image Fitting and Layout
DESCRIPTION: Methods for controlling how the image fits within its bounds and its alignment within the container.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_util_api.md#_snippet_8

LANGUAGE: APIDOC
CODE:
```
## Image Fitting & Layout

### `$image.fit` → BoxFitUtility

Controls how the image fits within its bounds.

- **`$image.fit(BoxFit value)`** → ImageStyler - Sets box fit behavior
- **`$image.fit.contain()`** → ImageStyler - Scale to fit inside bounds (maintain aspect ratio)
- **`$image.fit.cover()`** → ImageStyler - Scale to fill bounds (maintain aspect ratio, may crop)
- **`$image.fit.fill()`** → ImageStyler - Scale to fill bounds exactly (may distort)
- **`$image.fit.fitWidth()`** → ImageStyler - Scale to fit width
- **`$image.fit.fitHeight()`** → ImageStyler - Scale to fit height
- **`$image.fit.scaleDown()`** → ImageStyler - Scale down to fit (never scale up)

### `$image.alignment` → AlignmentUtility

Controls image alignment within its container.

- **`$image.alignment(AlignmentGeometry value)`** → ImageStyler - Sets alignment
- **`$image.alignment.topLeft()`** → ImageStyler - Align to top-left
- **`$image.alignment.topCenter()`** → ImageStyler - Align to top-center
- **`$image.alignment.topRight()`** → ImageStyler - Align to top-right
- **`$image.alignment.centerLeft()`** → ImageStyler - Align to center-left
- **`$image.alignment.center()`** → ImageStyler - Center alignment
- **`$image.alignment.centerRight()`** → ImageStyler - Align to center-right
- **`$image.alignment.bottomLeft()`** → ImageStyler - Align to bottom-left
- **`$image.alignment.bottomCenter()`** → ImageStyler - Align to bottom-center
- **`$image.alignment.bottomRight()`** → ImageStyler - Align to bottom-right
```

--------------------------------

TITLE: Layout & Positioning
DESCRIPTION: Methods for configuring image fitting, alignment, and repeat behavior.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_15

LANGUAGE: APIDOC
CODE:
```
## Layout & Positioning

### $image.fit → MixUtility
Provides image fitting configuration:
- **$image.fit(BoxFit)** → Sets how image fits within container
- **$image.fit.cover()**, **$image.fit.contain()**, **$image.fit.fill()** → Common fit modes
- **$image.fit.fitWidth()**, **$image.fit.fitHeight()** → Directional fitting
- **$image.fit.scaleDown()**, **$image.fit.none()** → Special fit modes

#### $image.alignment → MixUtility
Provides image alignment configuration:
- **$image.alignment(AlignmentGeometry)** → Sets image alignment within container
- **$image.alignment.center()**, **$image.alignment.topLeft()** → Alignment shortcuts

#### $image.repeat → MixUtility
Provides image repeat configuration:
- **$image.repeat(ImageRepeat)** → Sets image repeat behavior
- **$image.repeat.noRepeat()**, **$image.repeat.repeat()** → Repeat modes
- **$image.repeat.repeatX()**, **$image.repeat.repeatY()** → Directional repeat
```

--------------------------------

TITLE: Wrap Root Widget with MixTheme
DESCRIPTION: Demonstrates how to wrap the root widget of a Flutter application with MixTheme to apply a theme globally. This ensures that all child widgets can access the defined theme data.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/theming.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MixTheme(
      data: lightBlueTheme, // <- MixThemeData (In this guide we are using the lightBlueTheme or darkPurpleTheme)
      child: const MaterialApp(
        home: ProfilePage(),
      ),
    );
  }
}
```

--------------------------------

TITLE: Responsive Stack Alignment and Fit
DESCRIPTION: Demonstrates how to dynamically change a stack's alignment and fit properties based on screen breakpoints. This is useful for creating adaptive UIs that adjust to different screen sizes.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_util_api.md#_snippet_17

LANGUAGE: dart
CODE:
```
// Stack that changes alignment based on screen size
final responsiveStack = $stack
  .alignment.center()
  .fit.loose()
  .onBreakpoint(Breakpoint.md, $stack.alignment.topCenter())
  .onBreakpoint(Breakpoint.lg, $stack.fit.expand());

// Theme-aware stack
final themeStack = $stack
  .alignment.center()
  .onDark($stack.alignment.bottomCenter());
```

--------------------------------

TITLE: Style Composition and Overrides in Mix
DESCRIPTION: Illustrates composing styles by building new styles upon existing ones and overriding properties. This highlights reusability and managing style conflicts.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/guides/styling.mdx#_snippet_1

LANGUAGE: dart
CODE:
```
final base = BoxStyler()
    .paddingX(16)
    .paddingY(8)
    .borderRounded(8)
    .color(Colors.black)
    .wrapDefaultTextStyle(
      TextStyleMix()
        .color(Colors.deepOrange)
        .fontWeight(FontWeight.bold),
    );

final solid = base.color(Colors.blue);

final soft = base
    .color(Colors.blue.shade100)
    .wrapDefaultTextStyle(TextStyleMix().color(Colors.blue));
```

--------------------------------

TITLE: FlexBoxSpecUtility - BoxShadow
DESCRIPTION: Provides direct access to box shadow configuration.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flexbox/flexbox_util_api.md#_snippet_19

LANGUAGE: APIDOC
CODE:
```
## Set Box Shadow

### Description
Sets the box shadow for the flexbox layout.

### Method
POST

### Endpoint
/flexbox/shadow

### Parameters
#### Request Body
- **value** (BoxShadow) - Required - The box shadow to apply.

### Request Example
```json
{
  "value": {
    "color": "rgba(0,0,0,0.2)",
    "blurRadius": 5,
    "spreadRadius": 2,
    "offset": {
      "dx": 2,
      "dy": 2
    }
  }
}
```

### Response
#### Success Response (200)
- **message** (string) - Confirmation of box shadow configuration.

#### Response Example
```json
{
  "message": "Box shadow applied successfully."
}
```
```

--------------------------------

TITLE: StackSpecUtility: Fit Behavior
DESCRIPTION: Demonstrates configuring how non-positioned children are sized within a stack using `$stack.fit`. Options include loose, expand, and passthrough behaviors.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_util_api.md#_snippet_3

LANGUAGE: dart
CODE:
```
// Children can be smaller than the stack
$stack.fit.loose();

// Children are forced to expand to stack size
$stack.fit.expand();

// Stack takes the size of its children
$stack.fit.passthrough();
```

--------------------------------

TITLE: TextStyler: Advanced Styling and Typography
DESCRIPTION: Illustrates more complex text styling scenarios, including setting font family, letter spacing, line height, text decoration, text shadow, and utilizing predefined typography presets.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_60

LANGUAGE: dart
CODE:
```
final fancyStyle = $text
  .fontFamily('Roboto')
  .fontSize(20)
  .fontWeight.w600()
  .color.red()
  .decoration(TextDecoration.underline)
  .decorationColor.blue()
  .letterSpacing(1.2)
  .height(1.4)
  .shadows([Shadow(
    color: Colors.black26,
    offset: Offset(1, 1),
    blurRadius: 2,
  )]);

final headingStyle = $text.fontSize(24).fontWeight.bold().color.black();
final bodyStyle = $text.fontSize(14).color.grey.shade700();
final captionStyle = $text.fontSize(12).color.grey().italic();
```

--------------------------------

TITLE: Final Full Test Command
DESCRIPTION: This command runs a complete test suite for the entire 'mix' project after all refactoring phases are completed.

SOURCE: https://github.com/btwld/mix/blob/main/mix_architecture_consolidation_plan.md#_snippet_26

LANGUAGE: bash
CODE:
```
# Final full test:
melos run test:flutter
```

--------------------------------

TITLE: BoxStyler Alignment and Spacing
DESCRIPTION: Shows explicit alignment and various spacing helper methods available in BoxStyler for Flutter UI development.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/overview/utility-first.mdx#_snippet_1

LANGUAGE: dart
CODE:
```
// Explicit alignment
BoxStyler().alignment(Alignment.centerRight);

// Spacing helpers
BoxStyler().paddingAll(16); // All sides
BoxStyler().paddingX(12).paddingY(8); // Horizontal and vertical
BoxStyler().paddingOnly(horizontal: 12, vertical: 8); // Specific sides
```

--------------------------------

TITLE: Image Quality & Rendering
DESCRIPTION: Methods for configuring filter quality, anti-aliasing, and playback behavior.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_18

LANGUAGE: APIDOC
CODE:
```
## Image Quality & Rendering

#### $image.filterQuality → MixUtility
Provides filter quality configuration:
- **$image.filterQuality(FilterQuality)** → Sets scaling filter quality
- **$image.filterQuality.low()**, **$image.filterQuality.medium()**, **$image.filterQuality.high()** → Quality levels

- **$image.isAntiAlias(bool)** → Sets anti-aliasing behavior
- **$image.gaplessPlayback(bool)** → Sets gapless loading behavior
- **$image.matchTextDirection(bool)** → Sets text direction matching
```

--------------------------------

TITLE: Define Light Blue Theme Data with Mix
DESCRIPTION: Creates a MixThemeData instance for a light blue theme, specifying colors, text styles using Google Fonts, border radii, and spacing. This object serves as the design system for an application.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/theming.mdx#_snippet_4

LANGUAGE: dart
CODE:
```
final lightBlueTheme = MixThemeData(
  colors: {
    $token.color.primary: const Color(0xFF0093B9),
    $token.color.onPrimary: const Color(0xFFFAFAFA),
    $token.color.surface: const Color(0xFFFAFAFA),
    $token.color.onSurface: const Color(0xFF141C24),
    $token.color.onSurfaceVariant: const Color(0xFF405473),
  },
  textStyles: {
    $token.textStyle.headline1: GoogleFonts.plusJakartaSans(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    $token.textStyle.headline2: GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    $token.textStyle.headline3: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    $token.textStyle.body: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    $token.textStyle.callout: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  },
  radii: {
    $token.radius.large: const Radius.circular(100),
    $token.radius.medium: const Radius.circular(12),
  },
  spaces: {
    $token.space.medium: 16,
    $token.space.large: 24,
  },
);
```

--------------------------------

TITLE: Nesting Variants
DESCRIPTION: Demonstrates how to nest multiple variants to create complex conditional styling.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/guides/dynamic-styling.mdx#_snippet_5

LANGUAGE: APIDOC
CODE:
```
## Nesting Variants for Complex Styling

### Description
Combine multiple variants, such as hover states and dark/light mode, by nesting them within each other.

### Method
`BoxStyler.onHovered(BoxStyler.onDark(style).onLight(style))`

### Parameters
*   `onHovered` (BoxStyler) - The style to apply when hovered.
*   `onDark` (BoxStyler) - The style to apply in dark mode.
*   `onLight` (BoxStyler) - The style to apply in light mode.

### Request Example
```dart
final hoverStyle = BoxStyler()
  .onDark(BoxStyler().color(Colors.blue))
  .onLight(BoxStyler().color(Colors.green));

final style = BoxStyler()
  .color(Colors.red)
  .height(100)
  .width(100)
  .borderRounded(10)
  .onHovered(hoverStyle);
```

### Response
#### Success Response (200)
Applies the nested styles based on the combined active states.

#### Response Example
(Conceptual - style when hovered in dark mode)
```dart
// When hovered and in dark mode:
BoxStyler()
  .color(Colors.blue)
  .height(100)
  .width(100)
  .borderRounded(10);
```
```

--------------------------------

TITLE: StackStyler Constructor - Dart
DESCRIPTION: The main constructor for StackStyler, accepting optional parameters for all stack styling properties.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_style_api.md#_snippet_0

LANGUAGE: dart
CODE:
```
StackStyler({
  AlignmentGeometry? alignment,
  StackFit? fit,
  TextDirection? textDirection,
  Clip? clipBehavior,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<StackSpec>>? variants,
})
```

--------------------------------

TITLE: BoxSpecUtility - Deprecated On Methods
DESCRIPTION: Demonstrates the deprecated methods for applying styles based on context (hover, dark mode, light mode) and their recommended replacements. Direct methods like `$box.onHovered()` are preferred.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_8

LANGUAGE: dart
CODE:
```
// Deprecated: Apply style on hover
// $box.on.hover($box.color.blue())

// Deprecated: Apply style in dark mode
// $box.on.dark($box.color.black())

// Deprecated: Apply style in light mode
// $box.on.light($box.color.white())

// Recommended replacement: Apply style on hover
$box.onHovered($box.color.blue())

// Recommended replacement: Apply style in dark mode
$box.onDark($box.color.black())

// Recommended replacement: Apply style in light mode
$box.onLight($box.color.white())
```

--------------------------------

TITLE: BoxSpecUtility - Deprecated Methods
DESCRIPTION: Highlights deprecated methods for context-based styling and their recommended replacements.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_util_api.md#_snippet_17

LANGUAGE: APIDOC
CODE:
```
## BoxSpecUtility - Deprecated Methods

### Description
Deprecated methods for applying styles based on context (hover, dark mode, light mode).

### Deprecated Methods
- **$box.on.hover(BoxStyler style)**: Apply style on hover (Deprecated).
- **$box.on.dark(BoxStyler style)**: Apply style in dark mode (Deprecated).
- **$box.on.light(BoxStyler style)**: Apply style in light mode (Deprecated).

### Recommended Replacements
- Use `$box.onHovered(BoxStyler style)` instead of `$box.on.hover`.
- Use specific variant methods for dark/light mode if available, or context-aware modifiers.

### Example of Replacement
```dart
// Instead of:
$box.on.hover($box.color.blue())

// Use:
$box.onHovered($box.color.blue())
```
```

--------------------------------

TITLE: BoxStyler Instance Methods - Spacing
DESCRIPTION: Methods for managing padding and margin, including convenience methods for specific sides and directions.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_15

LANGUAGE: APIDOC
CODE:
```
## BoxStyler Instance Methods - Spacing

### Base Methods
- **padding(EdgeInsetsGeometryMix value)** → BoxStyler - Sets internal padding
- **margin(EdgeInsetsGeometryMix value)** → BoxStyler - Sets external margin

### Padding Convenience Methods
- **paddingAll(double value)** → BoxStyler - Sets padding on all sides
- **paddingTop(double value)** → BoxStyler - Sets top padding
- **paddingBottom(double value)** → BoxStyler - Sets bottom padding
- **paddingLeft(double value)** → BoxStyler - Sets left padding
- **paddingRight(double value)** → BoxStyler - Sets right padding
- **paddingX(double value)** → BoxStyler - Sets horizontal padding (left & right)
- **paddingY(double value)** → BoxStyler - Sets vertical padding (top & bottom)
- **paddingStart(double value)** → BoxStyler - Sets start padding (RTL-aware)
- **paddingEnd(double value)** → BoxStyler - Sets end padding (RTL-aware)
- **paddingOnly({double? horizontal, vertical, start, end, left, right, top, bottom})** → BoxStyler - Sets specific padding sides with priority resolution

### Margin Convenience Methods
- **marginAll(double value)** → BoxStyler - Sets margin on all sides
- **marginTop(double value)** → BoxStyler - Sets top margin
- **marginBottom(double value)** → BoxStyler - Sets bottom margin
- **marginLeft(double value)** → BoxStyler - Sets left margin
- **marginRight(double value)** → BoxStyler - Sets right margin
- **marginX(double value)** → BoxStyler - Sets horizontal margin (left & right)
- **marginY(double value)** → BoxStyler - Sets vertical margin (top & bottom)
- **marginStart(double value)** → BoxStyler - Sets start margin (RTL-aware)
- **marginEnd(double value)** → BoxStyler - Sets end margin (RTL-aware)
- **marginOnly({double? horizontal, vertical, start, end, left, right, top, bottom})** → BoxStyler - Sets specific margin sides with priority resolution
```

--------------------------------

TITLE: RTL-Aware Layouts and Directional Positioning
DESCRIPTION: Shows how to create layouts that are aware of Right-to-Left (RTL) text direction. This includes setting text direction and using alignment properties like `centerStart` and `topStart`.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_util_api.md#_snippet_25

LANGUAGE: dart
CODE:
```
// RTL-aware positioned stack
final rtlStack = $stack
  .alignment.centerStart()
  .textDirection.ltr()
  .fit.loose()
  .onLocale(Locale('ar'), $stack.textDirection.rtl());

// Directional overlay positioning
final directionalStack = $stack
  .alignment.topStart()
  .textDirection.ltr()
  .fit.expand();
```

--------------------------------

TITLE: Stack Layout Scenarios for UI Elements
DESCRIPTION: Presents various UI layout scenarios using stack styling, such as image overlays, profile pictures with status indicators, cards with floating elements, modal backdrops, toast positioning, and hero sections.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_style_api.md#_snippet_26

LANGUAGE: dart
CODE:
```
// Image with overlay text
final imageOverlay = $stack
  .alignment.bottomLeft()
  .fit.expand();

// Profile picture with status indicator  
final profileWithStatus = $stack
  .alignment.topRight()
  .fit.loose();

// Card with floating element
final cardWithFloat = $stack
  .alignment.topRight()
  .fit.loose();

// Modal backdrop
final modalBackdrop = $stack
  .alignment.center()
  .fit.expand();

// Toast/snackbar positioning
final toastPosition = $stack
  .alignment.bottomCenter()
  .fit.loose();

// Hero section with multiple layers
final heroSection = $stack
  .alignment.center()
  .fit.expand()
  .clipBehavior.antiAlias();
```

--------------------------------

TITLE: StackStyler Instance Methods
DESCRIPTION: Instance methods available on StackStyler objects for manipulating styles.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_style_api.md#_snippet_14

LANGUAGE: APIDOC
CODE:
```
## Instance Methods

### Layout Methods
- **alignment(AlignmentGeometry value)** → Sets stack alignment
- **fit(StackFit value)** → Sets stack fit behavior
- **textDirection(TextDirection value)** → Sets text direction
- **clipBehavior(Clip value)** → Sets clip behavior
- **modifier(ModifierConfig value)** → Adds widget modifiers
- **animate(AnimationConfig animation)** → Applies animation configuration
- **variants(List<VariantStyle<StackSpec>> variants)** → Sets conditional styling
- **wrap(ModifierConfig value)** → Alias for modifier()
```

--------------------------------

TITLE: Update Spec Utilities for New Mix Classes
DESCRIPTION: This snippet shows the updated 'spec_util.dart' file, ensuring that utility getters like $icon, $text, $box, and $flex now correctly reference the new Mix classes (IconSpecUtility, TextSpecUtility, BoxSpecUtility, FlexSpecUtility).

SOURCE: https://github.com/btwld/mix/blob/main/mix_architecture_consolidation_plan.md#_snippet_20

LANGUAGE: dart
CODE:
```
// IN: lib/src/specs/spec_util.dart
// Ensure all utilities use new Mix classes:
IconSpecUtility get $icon => IconSpecUtility();
TextSpecUtility get $text => TextSpecUtility();
BoxSpecUtility get $box => BoxSpecUtility();
FlexSpecUtility get $flex => FlexSpecUtility();
```

--------------------------------

TITLE: Create a Styled Box in Flutter
DESCRIPTION: This code demonstrates how to create and style a basic Box widget in Flutter. It sets the width, height, color, and border radius using the BoxStyler API.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/box.mdx#_snippet_0

LANGUAGE: dart
CODE:
```
Box(
  style: BoxStyler()
      .width(100)
      .height(100)
      .color(Colors.blue)
      .borderRounded(8),
  child: Text('Styled Box'),
);
```

--------------------------------

TITLE: BoxStyler Instance Methods - Core Layout
DESCRIPTION: Methods for setting alignment and clip behavior.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/box/box_style_api.md#_snippet_14

LANGUAGE: APIDOC
CODE:
```
## BoxStyler Instance Methods - Core Layout

### alignment(AlignmentGeometry value) → BoxStyler
Sets the alignment of the child within the box.

### clipBehavior(Clip value) → BoxStyler
Sets how the box clips its child.
```

--------------------------------

TITLE: ImageStyler Image Quality & Rendering
DESCRIPTION: Methods for controlling image quality and rendering.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_50

LANGUAGE: APIDOC
CODE:
```
## POST /api/imagestyler/filterQuality

### Description
Sets the filter quality for image scaling (low, medium, high).

### Method
POST

### Endpoint
/api/imagestyler/filterQuality

### Parameters
#### Request Body
- **value** (FilterQuality) - The FilterQuality value.

### Request Example
```json
{
  "value": "high"
}
```

### Response
#### Success Response (200)
- **updatedImageStyler** (ImageStyler) - The ImageStyler with the filter quality set.

#### Response Example
```json
{
  "updatedImageStyler": "updated_imagestyler_object"
}
```
```

LANGUAGE: APIDOC
CODE:
```
## POST /api/imagestyler/isAntiAlias

### Description
Sets whether anti-aliasing should be applied to the image.

### Method
POST

### Endpoint
/api/imagestyler/isAntiAlias

### Parameters
#### Request Body
- **value** (bool) - Whether to enable anti-aliasing.

### Request Example
```json
{
  "value": true
}
```

### Response
#### Success Response (200)
- **updatedImageStyler** (ImageStyler) - The ImageStyler with anti-aliasing setting.

#### Response Example
```json
{
  "updatedImageStyler": "updated_imagestyler_object"
}
```
```

LANGUAGE: APIDOC
CODE:
```
## POST /api/imagestyler/gaplessPlayback

### Description
Sets whether to maintain the previous image while loading a new one to prevent visual gaps.

### Method
POST

### Endpoint
/api/imagestyler/gaplessPlayback

### Parameters
#### Request Body
- **value** (bool) - Whether to enable gapless playback.

### Request Example
```json
{
  "value": true
}
```

### Response
#### Success Response (200)
- **updatedImageStyler** (ImageStyler) - The ImageStyler with gapless playback setting.

#### Response Example
```json
{
  "updatedImageStyler": "updated_imagestyler_object"
}
```
```

--------------------------------

TITLE: Creating Widgets with Icon Styling
DESCRIPTION: Illustrates different methods for creating Flutter widgets with customized icon styles, including using the Style.icon factory, the StyledIcon widget, and the call operator on an IconStyler instance.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/icon/icon_style_api.md#_snippet_56

LANGUAGE: dart
CODE:
```
// Using Style.icon() factory (common pattern)
final widget = Style.icon(
  color: Colors.blue,
  size: 24,
)(icon: Icons.star, semanticLabel: 'Favorite');

// Using StyledIcon widget directly
final widget = StyledIcon(
  icon: Icons.star,
  style: iconStyle,
  semanticLabel: 'Favorite',
);

// Using call operator on style
final widget = iconStyle(icon: Icons.star, semanticLabel: 'Favorite');
```

--------------------------------

TITLE: Image Source and Dimension Settings
DESCRIPTION: Utility methods for setting the image source and its dimensions (width and height) using the `$image` utility. These methods are chainable for fluent API usage.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_3

LANGUAGE: dart
CODE:
```
$image.image(ImageProvider<Object>)
```

LANGUAGE: dart
CODE:
```
$image.width(double)
```

LANGUAGE: dart
CODE:
```
$image.height(double)
```

--------------------------------

TITLE: Dart: Original LinearGradientUtility Usage
DESCRIPTION: Demonstrates the standard way to apply linear gradients with begin and end alignments using the Mix framework in Dart. This showcases the repetitive nature that custom utilities aim to solve.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/extending-utilities.md#_snippet_0

LANGUAGE: dart
CODE:
```
final style = Style(
  $box.linearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  
  // Or you can do this
  $box.linearGradient.begin.topCenter(),
  $box.linearGradient.end.bottomCenter(),
);

```

--------------------------------

TITLE: StackBoxStyler Instance Method: transformAlignment
DESCRIPTION: Illustrates the `transformAlignment` instance method for specifying the origin of the transformation. It returns a new StackBoxStyler with the adjusted transform alignment.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_15

LANGUAGE: dart
CODE:
```
transformAlignment(AlignmentGeometry value) → StackBoxStyler
```

--------------------------------

TITLE: Define Custom Color Tokens
DESCRIPTION: Illustrates how to create custom color design tokens using Mix's ColorToken class. This allows for defining specific color values that can be referenced throughout the application.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/tutorials/theming.mdx#_snippet_1

LANGUAGE: dart
CODE:
```
const primary = ColorToken('primary');
```

--------------------------------

TITLE: StackBoxStyler Factory Builder Constructor
DESCRIPTION: Introduces the factory constructor for StackBoxStyler, which accepts a builder function that receives a BuildContext. This is useful for creating styles that depend on the widget tree's context.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_box_style_api.md#_snippet_4

LANGUAGE: dart
CODE:
```
StackBoxStyler.builder(StackBoxStyler Function(BuildContext))
```

--------------------------------

TITLE: TextStyler Instance Methods - Display Properties
DESCRIPTION: Instance methods for setting various text display properties like overflow, max lines, and alignment.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_46

LANGUAGE: APIDOC
CODE:
```
## Instance Methods

### Text Display Properties

- **overflow(TextOverflow value)** → TextStyler - Sets how text overflow is handled (clip, ellipsis, fade, visible)
- **maxLines(int value)** → TextStyler - Sets the maximum number of lines for the text to span
- **softWrap(bool value)** → TextStyler - Sets whether text should break at soft line breaks
- **textAlign(TextAlign value)** → TextStyler - Sets how text is aligned horizontally within its container
- **textDirection(TextDirection value)** → TextStyler - Sets the directionality of the text (left-to-right or right-to-left)
- **textWidthBasis(TextWidthBasis value)** → TextStyler - Sets how the text's width is measured (parent width or text width)
```

--------------------------------

TITLE: FlexStyler Constructor
DESCRIPTION: The main constructor for FlexStyler, allowing all flex properties to be set directly. It accepts optional parameters for direction, alignment, size, spacing, animation, and more.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flex/flex_style_api.md#_snippet_9

LANGUAGE: dart
CODE:
```
FlexStyler({
  Axis? direction,
  MainAxisAlignment? mainAxisAlignment,
  CrossAxisAlignment? crossAxisAlignment,
  MainAxisSize? mainAxisSize,
  VerticalDirection? verticalDirection,
  TextDirection? textDirection,
  TextBaseline? textBaseline,
  Clip? clipBehavior,
  double? spacing,
  AnimationConfig? animation,
  ModifierConfig? modifier,
  List<VariantStyle<FlexSpec>>? variants,
})
```

--------------------------------

TITLE: StyledIcon Widget Styling with IconStyler
DESCRIPTION: Demonstrates styling for the StyledIcon widget, equivalent to Flutter's Icon widget. It uses IconStyler to set the icon's color and size. The StyledIcon widget requires an icon and a style object.

SOURCE: https://github.com/btwld/mix/blob/main/website/src/content/documentation/widgets/stylewidgets.mdx#_snippet_3

LANGUAGE: dart
CODE:
```
final iconStyle = IconStyler()
  .color(Colors.blue)
  .size(30);

StyledIcon(icon: Icons.ac_unit, style: iconStyle);
```

--------------------------------

TITLE: Media Layouts with Flexbox Utility
DESCRIPTION: Styles for media containers, including video thumbnails and album artwork. The utility allows specifying dimensions, border-radius, shadow effects, clipping behavior, and layout properties.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/flexbox/flexbox_util_api.md#_snippet_35

LANGUAGE: dart
CODE:
```
// Video thumbnail with overlay
final videoThumbnail = $flexbox
  .width.fixed(200)
  .height.fixed(112)
  .borderRadius.circular(8)
  .clipBehavior.hardEdge()
  .direction.column()
  .mainAxisAlignment.end()
  .padding.all(12);

// Album artwork container
final albumArtwork = $flexbox
  .width.fixed(150)
  .height.fixed(150)
  .borderRadius.circular(8)
  .shadow.medium()
  .clipBehavior.hardEdge()
  .direction.column()
  .mainAxisAlignment.end()
  .padding.all(8);
```

--------------------------------

TITLE: Text Style Properties via $text
DESCRIPTION: Details the various text style properties accessible through the $text utility.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_25

LANGUAGE: APIDOC
CODE:
```
## Utility Methods (via $text)

### Text Style Properties

#### $text.style → TextStyleUtility

Core text styling utility providing comprehensive typography controls:
- **$text.style.fontSize(double)** → Sets font size in logical pixels
- **$text.style.fontFamily(String)** → Sets font family
- **$text.style.fontWeight** → FontWeight utility (with .bold() shortcut)
- **$text.style.fontStyle** → FontStyle utility (with .italic() shortcut) 
- **$text.style.color** → ColorUtility for text color
- **$text.style.backgroundColor** → ColorUtility for background color
- **$text.style.decoration** → TextDecoration utility (underline, overline, etc.)
- **$text.style.decorationColor** → ColorUtility for decoration color
- **$text.style.decorationStyle** → TextDecorationStyle utility
- **$text.style.decorationThickness(double)** → Sets decoration thickness
- **$text.style.height(double)** → Sets line height multiplier
- **$text.style.letterSpacing(double)** → Sets letter spacing
- **$text.style.wordSpacing(double)** → Sets word spacing
- **$text.style.textBaseline** → TextBaseline utility
- **$text.style.shadows(List<Shadow>)** → Sets text shadows
- **$text.style.fontVariations(List<FontVariation>)** → Sets variable font axes
- **$text.style.fontFeatures(List<FontFeature>)** → Sets font features
- **$text.style.foreground(Paint)** → Sets foreground paint
- **$text.style.background(Paint)** → Sets background paint
- **$text.style.fontFamilyFallback(List<String>)** → Sets fallback fonts
- **$text.style.debugLabel(String)** → Sets debug label
```

--------------------------------

TITLE: Typography Instance Methods
DESCRIPTION: Methods for setting various typography properties including color, background color, font size, weight, style, family, and fallback fonts. These methods allow for comprehensive customization of the text's appearance.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/text/text_style_api.md#_snippet_36

LANGUAGE: dart
CODE:
```
color(Color value) → TextStyler
backgroundColor(Color value) → TextStyler
fontSize(double value) → TextStyler
fontWeight(FontWeight value) → TextStyler
fontStyle(FontStyle value) → TextStyler
fontFamily(String value) → TextStyler
fontFamilyFallback(List<String> value) → TextStyler
```

--------------------------------

TITLE: Create StyledImage Widget
DESCRIPTION: Creates a StyledImage widget with optional parameters for advanced image handling. This method is essential for instantiating the StyledImage with custom configurations.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/image/image_style_api.md#_snippet_20

LANGUAGE: dart
CODE:
```
StyledImage call({
  ImageProvider? image,
  ImageFrameBuilder? frameBuilder,
  ImageLoadingBuilder? loadingBuilder,
  ImageErrorWidgetBuilder? errorBuilder,
  Animation<double>? opacity,
})
```

--------------------------------

TITLE: StackStyler Static Properties
DESCRIPTION: Static properties and accessors for StackStyler.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/stack/stack_style_api.md#_snippet_16

LANGUAGE: APIDOC
CODE:
```
## Static Properties

### StackStyler.chain → StackSpecUtility
Static accessor providing utility methods for chaining stack styling operations.
```

--------------------------------

TITLE: Mutable Building with Utilities
DESCRIPTION: Shows how utilities maintain mutable state during the building process, allowing properties to be chained and updated before the final immutable style is created using the `.build()` method.

SOURCE: https://github.com/btwld/mix/blob/main/packages/mix/lib/src/specs/spec_util_api.md#_snippet_16

LANGUAGE: dart
CODE:
```
final builder = $box;         // Mutable state starts empty
builder.color.red();          // Mutable state updated
builder.padding.all(16);      // Mutable state updated again
final style = builder.build(); // Immutable style created
```