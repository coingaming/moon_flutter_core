This file is a merged representation of a subset of the codebase, containing specifically included files, combined into a single document by Repomix.
The content has been processed where security check has been disabled.

<file_summary>
This section contains a summary of this file.

<purpose>
This file contains a packed representation of a subset of the repository's contents that is considered the most important context.
It is designed to be easily consumable by AI systems for analysis, code review,
or other automated processes.
</purpose>

<file_format>
The content is organized as follows:
1. This summary section
2. Repository information
3. Directory structure
4. Repository files (if enabled)
5. Multiple file entries, each consisting of:
  - File path as an attribute
  - Full contents of the file
</file_format>

<usage_guidelines>
- This file should be treated as read-only. Any changes should be made to the
  original repository files, not this packed version.
- When processing this file, use the file path to distinguish
  between different files in the repository.
- Be aware that this file may contain sensitive information. Handle it with
  the same level of security as you would the original repository.
</usage_guidelines>

<notes>
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Only files matching these patterns are included: packages/mix/example/**/*.dart
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded
- Security check has been disabled - content may contain sensitive information
- Files are sorted by Git change count (files with more changes are at the bottom)
</notes>

</file_summary>

<directory_structure>
packages/
  mix/
    example/
      lib/
        api/
          animation/
            implicit.curved.hover.dart
            implicit.curved.scale.dart
            implicit.spring.translate.dart
            keyframe.heart.dart
            keyframe.icon_selector.dart
            keyframe.loop.dart
            keyframe.switch.dart
            phase.arrow.dart
            phase.compress.dart
            widget_state_animation.dart
          context_variants/
            disabled.dart
            focused.dart
            hovered.dart
            on_dark_light.dart
            pressed.dart
            responsive_size.dart
            selected_toggle.dart
            selected.dart
          design_tokens/
            theme_tokens.dart
          gradients/
            gradient_linear.dart
            gradient_radial.dart
            gradient_sweep.dart
          shaders/
            linear_gradient.dart
            radial_gradient.dart
            sweep_gradient.dart
          text/
            text_directives.dart
          widgets/
            box/
              gradient_box.dart
              simple_box.dart
            hbox/
              icon_label_chip.dart
            icon/
              styled_icon.dart
            text/
              styled_text.dart
            vbox/
              card_layout.dart
            zbox/
              layered_boxes.dart
        components/
          chip_button.dart
          custom_scaffold.dart
          tokens.dart
        docs/
          guides/
            animations.dart
            directives.dart
            styling.dart
            variants.dart
          overview/
            comparison.dart
            getting_started.dart
            index.dart
            utility_first.dart
          widgets/
            box.dart
            flexbox.dart
            icon.dart
            image.dart
            pressable.dart
            stylewidgets.dart
        examples/
          okinawa.card.dart
        helpers.dart
        main.dart
      test/
        widget_test.dart
</directory_structure>

<files>
This section contains the contents of the repository's files.

<file path="packages/mix/example/lib/api/animation/implicit.curved.hover.dart">
/// Hover Scale Animation Example
///
/// This example shows how to create smooth animations that respond to hover
/// interactions. The box scales up when the mouse hovers over it.
///
/// Key concepts:
/// - Using .onHovered() variant for hover states
/// - Applying .scale() transformation
/// - Adding .animate() for smooth transitions
/// - Transform alignment with .transformAlignment()
library;

import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.black)
        .height(100)
        .width(100)
        .borderRounded(10)
        .transform(Matrix4.identity())
        .onHovered(
          BoxStyler()
              .color(Colors.blue)
              .scale(1.5)
              .animate(AnimationConfig.easeInOut(1000.ms)),
        )
        .animate(AnimationConfig.linear(300.ms));

    return Box(style: style);
  }
}
</file>

<file path="packages/mix/example/lib/api/animation/implicit.curved.scale.dart">
import '../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool appear = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        appear = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.black)
        .height(100)
        .width(100)
        .borderRounded(10)
        .translate(appear ? 0 : -50, 0)
        .scale(appear ? 1 : 0.1)
        .animate(AnimationConfig.easeInOut(1.s));

    return Box(style: style);
  }
}
</file>

<file path="packages/mix/example/lib/api/animation/implicit.spring.translate.dart">
import '../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool _translated = false;

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.black)
        .height(100)
        .width(100)
        .borderRounded(10)
        .transform(Matrix4.identity())
        .translate(0, _translated ? 100 : -100)
        .animate(AnimationConfig.spring(300.ms, bounce: 0.6));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Box(style: style),
        TextButton(
          onPressed: () {
            setState(() {
              _translated = !_translated;
            });
          },
          child: Text('Play'),
        ),
      ],
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/animation/keyframe.heart.dart">
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(home: DemoApp());
  }
}

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: HeartAnimation()),
      backgroundColor: Colors.white,
    );
  }
}

class HeartAnimation extends StatefulWidget {
  const HeartAnimation({super.key});

  @override
  State<HeartAnimation> createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation> {
  final ValueNotifier<int> _trigger = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _trigger.value++;
        });
      },
      child: Box(
        style: BoxStyler().keyframeAnimation(
          trigger: _trigger,
          timeline: [
            KeyframeTrack<double>('scale', [
              Keyframe.linear(1.0, 360.ms),
              Keyframe.elasticOut(1.5, 800.ms),
              Keyframe.elasticOut(1.0, 800.ms),
            ], initial: 1.0),
            KeyframeTrack<double>('verticalOffset', [
              Keyframe.linear(0.0, 100.ms),
              Keyframe.easeIn(20.0, 150.ms),
              Keyframe.elasticOut(-60.0, 1000.ms),
              Keyframe.elasticOut(0.0, 800.ms),
            ], initial: 0.0),
            KeyframeTrack<double>('verticalStretch', [
              Keyframe.ease(1.0, 100.ms),
              Keyframe.ease(0.6, 150.ms),
              Keyframe.ease(1.5, 100.ms),
              Keyframe.ease(1.05, 150.ms),
              Keyframe.ease(1.0, 880.ms),
              Keyframe.ease(0.8, 100.ms),
              Keyframe.ease(1.04, 400.ms),
              Keyframe.ease(1.0, 220.ms),
            ], initial: 1.0),
            KeyframeTrack<double>('angle', [
              Keyframe.easeIn(0.0, 580.ms),
              Keyframe.easeIn(16.0 * (pi / 180), 125.ms),
              Keyframe.easeIn(-16.0 * (pi / 180), 125.ms),
              Keyframe.easeIn(16.0 * (pi / 180), 125.ms),
              Keyframe.easeIn(0.0, 125.ms),
            ], initial: 0.0),
          ],
          styleBuilder: (values, style) {
            final scale = values.get('scale');
            final verticalOffset = values.get('verticalOffset');
            final verticalStretch = values.get('verticalStretch');
            final angle = values.get('angle');

            return style
                .wrapScale(x: scale, y: scale * verticalStretch)
                .wrapTranslate(x: 0, y: verticalOffset)
                .wrapRotate(angle);
          },
        ),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.redAccent.shade100, Colors.redAccent.shade400],
            ).createShader(bounds);
          },
          child: StyledIcon(
            icon: CupertinoIcons.heart_fill,
            style: IconMix().size(100).color(Colors.white),
          ),
        ),
      ),
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/animation/keyframe.icon_selector.dart">
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(home: DemoApp());
  }
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: Center(child: EmojiSelector()),
    );
  }
}

class EmojiSelector extends StatelessWidget {
  const EmojiSelector({super.key});

  @override
  Widget build(BuildContext context) {
    Widget emoji(String emoji) {
      return StyledText(emoji, style: TextStyler().fontSize(25));
    }

    return FlexBox(
      style: FlexBoxStyler()
          .padding(EdgeInsetsMix.symmetric(vertical: 10, horizontal: 16))
          .color(Colors.white)
          .borderRounded(50)
          .shadowOnly(color: Colors.black12, blurRadius: 50)
          .spacing(16)
          .mainAxisAlignment(MainAxisAlignment.center)
          .mainAxisSize(MainAxisSize.min),

      children: [
        PopUpAnimation(child: emoji('❤️')),
        PopUpAnimation(delay: 100.ms, child: emoji('🤑')),
        PopUpAnimation(delay: 200.ms, child: emoji('👍')),
        PopUpAnimation(delay: 300.ms, child: emoji('👎')),
        PopUpAnimation(delay: 400.ms, child: emoji('🤣')),
      ],
    );
  }
}

class PopUpAnimation extends StatefulWidget {
  const PopUpAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration delay;

  @override
  State<PopUpAnimation> createState() => _PopUpAnimationState();
}

class _PopUpAnimationState extends State<PopUpAnimation> {
  final trigger = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () => trigger.value = true);
  }

  @override
  void dispose() {
    trigger.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Box(
      style: BoxStyler().keyframeAnimation(
        trigger: trigger,
        timeline: [
          KeyframeTrack<double>('scale', [
            Keyframe.ease(0.2, 200.ms),
            Keyframe.elasticOut(1.0, 1000.ms),
          ], initial: 0),
          KeyframeTrack<double>('y', [
            Keyframe.elasticOut(0, 800.ms),
          ], initial: -100),
          KeyframeTrack<double>('opacity', [
            Keyframe.easeIn(1.0, 500.ms),
          ], initial: 0),
        ],
        styleBuilder: (values, style) {
          final scale = values.get('scale');
          final y = values.get('y');
          final opacity = values.get('opacity');

          return style
              .transform(
                Matrix4.identity()
                  ..scaleByDouble(scale, scale, 1, 1)
                  ..translateByDouble(0.0, y, 0, 1),
              )
              .wrapOpacity(opacity);
        },
      ),
      child: widget.child,
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/animation/keyframe.loop.dart">
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(home: DemoApp());
  }
}

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  final trigger = ValueNotifier(0);
  Timer? _timer;

  BoxMix get _boxStyle => BoxStyler()
      .color(Colors.blueAccent.shade400)
      .paddingX(16)
      .paddingY(8)
      .borderRounded(30)
      .foregroundLinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0),
          Colors.white.withValues(alpha: 0.2),
          Colors.white.withValues(alpha: 0.2),
          Colors.white.withValues(alpha: 0),
        ],
        stops: [0.0, 0.3, 0.4, 1],
        tileMode: TileMode.clamp,
      )
      .keyframeAnimation(
        trigger: trigger,
        timeline: [
          KeyframeTrack<double>('progress', [
            Keyframe.ease(1, 2000.ms),
          ], initial: -1),
        ],
        styleBuilder: (values, style) => style.foregroundDecoration(
          BoxDecorationMix.gradient(
            LinearGradientMix(
              transform: _SlidingGradientTransform(
                slidePercent: values.get('progress'),
              ),
            ),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(5.s, (timer) {
      trigger.value++;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Box(
          style: _boxStyle,
          child: StyledText(
            'Update',
            style: TextStyler()
                //
                .color(Colors.white)
                .fontWeight(FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.identity()
      ..translateByDouble(bounds.width * slidePercent, 0.0, 0.0, 1);
  }
}
</file>

<file path="packages/mix/example/lib/api/animation/keyframe.switch.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers.dart';

void main() {
  runMixApp(SwitchAnimation());
}

class SwitchAnimation extends StatefulWidget {
  const SwitchAnimation({super.key});

  @override
  State<SwitchAnimation> createState() => _SwitchAnimationState();
}

class _SwitchAnimationState extends State<SwitchAnimation> {
  final ValueNotifier<bool> _trigger = ValueNotifier(false);

  @override
  void dispose() {
    _trigger.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Pressable(
        onPress: () {
          setState(() {
            _trigger.value = !_trigger.value;
          });
        },
        child: Box(
          style: BoxStyler()
              .color(
                _trigger.value ? Colors.deepPurpleAccent : Colors.grey.shade300,
              )
              .height(30)
              .width(65)
              .borderRadiusAll(Radius.circular(40))
              .alignment(
                _trigger.value ? Alignment.centerRight : Alignment.centerLeft,
              )
              .animate(AnimationConfig.easeOut(300.ms)),
          child: Box(
            style: BoxStyler()
                .height(30)
                .width(40)
                .color(Colors.white)
                .foregroundRadialGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                  stops: [0.3, 1],
                  focal: Alignment.center,
                  focalRadius: 1.1,
                )
                .borderRounded(40)
                .scale(0.85)
                .shadowOnly(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: Offset(2, 4),
                  blurRadius: 4,
                  spreadRadius: 3,
                )
                .keyframeAnimation(
                  trigger: _trigger,
                  timeline: [
                    KeyframeTrack<double>('scale', [
                      Keyframe.easeOutSine(1.25, 200.ms),
                      Keyframe.elasticOut(0.85, 500.ms),
                    ], initial: 0.85),
                    KeyframeTrack<double>(
                      'width',
                      [
                        Keyframe.decelerate(50, 100.ms),
                        Keyframe.linear(50, 100.ms),
                        Keyframe.elasticOut(40, 500.ms),
                      ],
                      initial: 40,
                      tweenBuilder: Tween.new,
                    ),
                  ],
                  styleBuilder: (values, style) => style
                      .scale(values.get('scale'))
                      .width(values.get('width')),
                ),
          ),
        ),
      ),
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/animation/phase.arrow.dart">
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: Scaffold(body: Center(child: Example())),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final trigger = ValueNotifier(0);

  @override
  void dispose() {
    trigger.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => trigger.value++,
      child: RowBox(
        style: FlexBoxStyler()
            .color(Colors.white)
            .paddingX(16)
            .paddingY(8)
            .borderRounded(10)
            .border(BoxBorderMix.all(BorderSideMix.color(Colors.grey.shade200)))
            .mainAxisSize(MainAxisSize.min)
            .spacing(8)
            .onHovered(
              FlexBoxStyler().border(
                BoxBorderMix.all(BorderSideMix.color(Colors.grey.shade300)),
              ),
            )
            .animate(AnimationConfig.easeInOut(150.ms)),

        children: [
          Text('Developer Preview'),
          ArrowIconButton(animationTrigger: trigger),
        ],
      ),
    );
  }
}

enum ArrowPhases {
  identity,
  topRight,
  bottomLeft;

  Offset get offset => switch (this) {
    identity => Offset.zero,
    topRight => const Offset(16, -16),
    bottomLeft => const Offset(-16, 16),
  };

  Duration get duration => switch (this) {
    identity => 500.ms,
    topRight => 200.ms,
    bottomLeft => 1.ms,
  };

  Curve get curve => switch (this) {
    identity => SpringCurve.withDampingRatio(ratio: 0.4),
    topRight || bottomLeft => Curves.easeOut,
  };
}

class ArrowIconButton extends StatelessWidget {
  const ArrowIconButton({super.key, required this.animationTrigger});
  final ValueNotifier animationTrigger;
  @override
  Widget build(BuildContext context) {
    final boxContainer = BoxStyler()
        .color(Colors.grey.shade200)
        .borderRadius(BorderRadiusMix.circular(10))
        .size(20, 20)
        .clipBehavior(Clip.hardEdge);

    final icon = IconStyler()
        .color(Colors.grey.shade500)
        .size(14)
        .phaseAnimation(
          trigger: animationTrigger,
          phases: ArrowPhases.values,
          styleBuilder: (phase, style) =>
              style.wrapTranslate(x: phase.offset.dx, y: phase.offset.dy),
          configBuilder: (phase) => CurveAnimationConfig(
            duration: phase.duration,
            curve: phase.curve,
          ),
        );

    return boxContainer(child: icon(icon: CupertinoIcons.arrow_up_right));
  }
}
</file>

<file path="packages/mix/example/lib/api/animation/phase.compress.dart">
/// Tap Phase Animation Example
///
/// Demonstrates multi-phase animations that respond to user taps. The animation
/// progresses through three distinct phases: initial, compress, and expanded.
///
/// Key concepts:
/// - Using .phaseAnimation() for complex state-based animations
/// - Defining animation phases with enums
/// - Different animation configs for each phase
/// - ValueNotifier for animation triggers
/// - Transform alignment and scaling
library;

import '../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(BlockAnimation());
}

enum AnimationPhases { initial, compress, expanded }

class BlockAnimation extends StatefulWidget {
  const BlockAnimation({super.key});

  @override
  State<BlockAnimation> createState() => _BlockAnimationState();
}

class _BlockAnimationState extends State<BlockAnimation> {
  final _isExpanded = ValueNotifier(false);

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = $box
        .color(Colors.deepPurple)
        .height(100)
        .width(100)
        .borderRounded(40)
        .phaseAnimation(
          trigger: _isExpanded,
          phases: AnimationPhases.values,
          styleBuilder: (phase, style) => switch (phase) {
            AnimationPhases.initial => style.scale(1),
            AnimationPhases.compress =>
              style.scale(0.75).color(Colors.red.shade800),
            AnimationPhases.expanded =>
              style.scale(1.25).borderRounded(20).color(Colors.yellow.shade300),
          },
          configBuilder: (phase) => switch (phase) {
            AnimationPhases.initial =>
              CurveAnimationConfig.springWithDampingRatio(800.ms, ratio: 0.3),
            AnimationPhases.compress => CurveAnimationConfig.decelerate(200.ms),
            AnimationPhases.expanded => CurveAnimationConfig.decelerate(100.ms),
          },
        );

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded.value = !_isExpanded.value;
        });
      },
      child: Box(style: style),
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/animation/widget_state_animation.dart">
import '../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool appear = false;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     appear = true;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.black)
        .height(100)
        .width(100)
        .borderRounded(10)
        .onHovered(BoxStyler().color(Colors.blue))
        .onPressed(
          BoxStyler().color(Colors.red).animate(AnimationConfig.easeIn(200.ms)),
        );
    // .animate(AnimationConfig.easeIn(2.s));
    // .translate(appear ? 0 : -50, 0)
    // .scale(appear ? 1 : 0.1)
    // .animate(AnimationConfig.easeInOut(500.ms));

    return Box(style: style);
  }
}
</file>

<file path="packages/mix/example/lib/api/context_variants/disabled.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.red)
        .height(100)
        .width(100)
        .borderRounded(10)
        .onDisabled(BoxStyler().color(Colors.grey));

    return Pressable(enabled: false, child: Box(style: style));
  }
}
</file>

<file path="packages/mix/example/lib/api/context_variants/focused.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  late FocusNode focusNode1;
  late FocusNode focusNode2;

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.red)
        .height(100)
        .width(100)
        .borderRounded(10)
        .wrapOpacity(0.4)
        .onFocused(
          BoxStyler()
              .color(Colors.blue)
              .borderAll(color: Colors.blue.shade700, width: 3),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Pressable(
              onPress: () {
                // Request focus when pressed
                focusNode1.requestFocus();
              },
              focusNode: focusNode1,
              child: Box(style: style),
            ),
            Pressable(
              onPress: () {
                // Request focus when pressed
                focusNode2.requestFocus();
              },
              focusNode: focusNode2,
              child: Box(style: style),
            ),
          ],
        ),
        Text(
          'Click a box to focus it, or use Tab key to navigate',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/context_variants/hovered.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.red)
        .height(100)
        .width(100)
        .borderRounded(10)
        .onHovered(BoxStyler().color(Colors.blue));

    return Box(style: style);
  }
}
</file>

<file path="packages/mix/example/lib/api/context_variants/on_dark_light.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    // Button style that adapts to dark/light mode
    final buttonStyle = BoxStyler()
        .height(60)
        .width(60)
        .borderRounded(30)
        .color(Colors.grey.shade200)
        .animate(AnimationConfig.easeInOut(600.ms))
        .onDark(BoxStyler().color(Colors.grey.shade800))
        .shadowOnly(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: Offset(0, 4),
        );

    // Icon style that adapts to dark/light mode
    final iconStyle = IconStyler()
        .color(Colors.grey.shade800)
        .size(28)
        .icon(Icons.dark_mode)
        .animate(AnimationConfig.easeInOut(200.ms))
        .onDark(IconStyler().icon(Icons.light_mode).color(Colors.yellow));

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        platformBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      child: PressableBox(
        style: buttonStyle,
        onPress: () => setState(() => isDark = !isDark),
        child: StyledIcon(style: iconStyle),
      ),
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/context_variants/pressed.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.red)
        .height(100)
        .width(100)
        .borderRounded(10)
        .onPressed(BoxStyler().color(Colors.blue));

    return Pressable(
      onPress: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Pressed!')));
      },
      child: Box(style: style),
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/context_variants/responsive_size.dart">
import '../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .width(100)
        .height(100)
        .color(Colors.blue.shade400)
        .onBreakpoint(Breakpoint.xs, BoxStyler().color(Colors.green))
        .borderRounded(16)
        .shadowOnly(color: Colors.black.withValues(alpha: 0.2), blurRadius: 20)
        .wrapDefaultTextStyle(
          TextStyleMix()
              .fontSize(16)
              .fontWeight(FontWeight.bold)
              .color(Colors.white),
        )
        .wrap(WidgetModifierConfig.align(alignment: Alignment.center))
        .animate(AnimationConfig.spring(const Duration(milliseconds: 300)));

    return Center(
      child: Box(
        style: style,
        child: Center(child: Text('Resize window!')),
      ),
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/context_variants/selected_toggle.dart">
import '../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final controller = WidgetStatesController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .height(60)
        .width(120)
        .borderRounded(30)
        .color(Colors.grey.shade200)
        .borderAll(color: Colors.grey.shade300, width: 2)
        .animate(AnimationConfig.spring(300.ms))
        .onSelected(BoxStyler()
          .color(Colors.blue.shade500)
          .borderAll(color: Colors.blue.shade600, width: 2)
          .shadowOnly(
            color: Colors.blue.shade200,
            blurRadius: 10,
            spreadRadius: 2,
          )
        );

    final textStyle = TextStyler()
        .fontSize(16)
        .fontWeight(FontWeight.w600)
        .color(Colors.grey.shade700)
        .onSelected(TextStyler().color(Colors.white));

    return Pressable(
      controller: controller,
      onPress: () {
        final isSelected = controller.has(WidgetState.selected);
        controller.update(WidgetState.selected, !isSelected);
      },
      child: Box(
        style: style,
        child: Center(
          child: StyledText(
            controller.has(WidgetState.selected) ? 'Selected' : 'Select Me',
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/context_variants/selected.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final controller = WidgetStatesController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.red)
        .height(100)
        .width(100)
        .borderRounded(10)
        .onSelected(BoxStyler().color(Colors.blue));

    return Pressable(
      controller: controller,
      onPress: () {
        final isSelected = controller.has(WidgetState.selected);
        controller.update(WidgetState.selected, !isSelected);
      },
      child: Box(style: style),
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/design_tokens/theme_tokens.dart">
/// Theme Tokens Example
///
/// Shows how to use design tokens for consistent theming across your app.
/// Design tokens allow you to define reusable values that can be referenced
/// throughout your styles and updated in one place.
///
/// Key concepts:
/// - Creating individual token types (ColorToken, RadiusToken, etc.)
/// - Using tokens in styles with direct calls
/// - Providing token values through MixScope with typed parameters
/// - Building a design system with consistent values
library;

import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers.dart';

void main() {
  runMixApp(Example());
}

// Create individual token instances using specific token types
final $primaryColor = ColorToken('primary');
final $pill = RadiusToken('pill');
final $spacing = SpaceToken('spacing.large');

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return MixScope(
      colors: {$primaryColor: Colors.blue},
      radii: {$pill: Radius.circular(20)},
      spaces: {$spacing: 16.0},
      child: _Example(),
    );
  }
}

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .borderRadiusTopLeft($pill())
        .color($primaryColor())
        .height(100)
        .width(100)
        .paddingAll(16.0);

    return Box(style: style);
  }
}
</file>

<file path="packages/mix/example/lib/api/gradients/gradient_linear.dart">
import '../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .height(100)
        .width(200)
        .borderRounded(16)
        .shadowOnly(
          color: Colors.purple.shade200,
          offset: Offset(0, 8),
          blurRadius: 20,
        )
        .linearGradient(
          colors: [Colors.purple.shade400, Colors.pink.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

    return Box(style: style);
  }
}
</file>

<file path="packages/mix/example/lib/api/gradients/gradient_radial.dart">
import '../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .height(150)
        .width(150)
        .borderRounded(75)
        .shadowOnly(
          color: Colors.orange.shade400,
          blurRadius: 30,
          spreadRadius: 5,
        )
        .radialGradient(
          colors: [Colors.orange.shade300, Colors.deepOrange.shade600],
          center: Alignment(-0.3, -0.3),
          radius: 1.2,
          focal: Alignment(-0.1, -0.1),
          focalRadius: 0.1,
        );

    return Box(style: style);
  }
}
</file>

<file path="packages/mix/example/lib/api/gradients/gradient_sweep.dart">
import 'dart:math' as math;

import '../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .height(120)
        .width(120)
        .borderRounded(60)
        .shadowOnly(
          color: Colors.purple.shade300,
          blurRadius: 25,
          spreadRadius: 2,
        )
        .sweepGradient(
          colors: [
            Colors.blue.shade400,
            Colors.purple.shade400,
            Colors.pink.shade400,
            Colors.orange.shade400,
            Colors.blue.shade400,
          ],
          center: Alignment.center,
          startAngle: 0,
          endAngle: math.pi * 2,
        );

    return Box(style: style);
  }
}
</file>

<file path="packages/mix/example/lib/api/shaders/linear_gradient.dart">
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: LinearGradientIconExample())),
    );
  }
}

class LinearGradientIconExample extends StatelessWidget {
  const LinearGradientIconExample({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledIcon(
      icon: CupertinoIcons.heart_fill,
      style: IconStyler()
          .size(100)
          .color(Colors.white)
          .wrap(
            WidgetModifierConfig.shaderMask(
              shaderCallback: ShaderCallbackBuilder.linearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.redAccent.shade100,
                  Colors.redAccent.shade200,
                  Colors.redAccent.shade700,
                ],
              ),
            ),
          ),
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/shaders/radial_gradient.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: LinearGradientIconExample())),
    );
  }
}

class LinearGradientIconExample extends StatelessWidget {
  const LinearGradientIconExample({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledText(
      'Hello',
      style: TextStyler()
          .fontSize(100)
          .color(Colors.white)
          .fontWeight(FontWeight.bold)
          .wrap(
            WidgetModifierConfig.shaderMask(
              shaderCallback: ShaderCallbackBuilder.radialGradient(
                center: Alignment.centerLeft,
                radius: 0.7,
                colors: [
                  Colors.blueAccent.shade100,
                  Colors.blueAccent.shade700,
                ],
              ),
            ),
          ),
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/shaders/sweep_gradient.dart">
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: SweepGradientIconExample())),
    );
  }
}

class SweepGradientIconExample extends StatelessWidget {
  const SweepGradientIconExample({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledIcon(
      icon: CupertinoIcons.clock_solid,
      style: IconStyler()
          .size(100)
          .color(Colors.white)
          .wrap(
            WidgetModifierConfig.shaderMask(
              shaderCallback: ShaderCallbackBuilder.sweepGradient(
                center: Alignment.topCenter,
                colors: [
                  Colors.redAccent.shade100,
                  Colors.redAccent.shade400,
                  Colors.redAccent.shade200,
                ],
              ),
            ),
          ),
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/text/text_directives.dart">
import '../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyler()
        .fontSize(18)
        .fontWeight(FontWeight.w600)
        .color(Colors.blue.shade700);

    return ColumnBox(
      style: FlexBoxStyler().spacing(16).mainAxisSize(MainAxisSize.min),
      children: [
        StyledText('hello world', style: baseStyle.uppercase()),
        StyledText('HELLO WORLD', style: baseStyle.lowercase()),
        StyledText('hello world', style: baseStyle.capitalize()),
        StyledText('hello world from mix', style: baseStyle.titleCase()),
        StyledText(
          'hello world. this is mix.',
          style: baseStyle.sentenceCase(),
        ),
      ],
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/widgets/box/gradient_box.dart">
import '../../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .height(50)
        .width(100)
        .borderRounded(10)
        .linearGradient(
          colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
        .shadowOnly(
          color: Colors.deepPurple.shade700,
          offset: Offset(0, 4),
          blurRadius: 10,
        );

    return Box(style: style);
  }
}
</file>

<file path="packages/mix/example/lib/api/widgets/box/simple_box.dart">
/// Simple Box Example
///
/// This example demonstrates the basic usage of the Box widget with Mix styling.
/// Shows how to apply color, dimensions, and border radius to create a simple
/// styled container.
///
/// Key concepts:
/// - Using BoxStyle() to create box styles
/// - Setting color, width, and height properties
/// - Applying border radius with BorderRadiusMix
// ignore_for_file: unused_local_variable

library;

import '../../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    // OLD Syntax
    // final boxStyle = Style(
    //   $box.color(Colors.red),
    //   $box.height(100),
    //   $box.width(100),
    //   $box.borderRadius(10),
    // );

    // NEW Fluent API with dot notation
    final fluentStyle = $box
        .color(Colors.red)
        .height(100)
        .width(100)
        .borderRounded(10);

    /// Builder Pattern Syntax for backwards compatibility
    final builderStyle = $box
      ..color.red()
      ..height(100)
      ..width(100)
      ..borderRadius.circular(10);

    final boxStyle = BoxStyler()
        .color(Colors.red)
        .size(100, 100)
        .borderRounded(10);

    return Box(style: boxStyle);
    // or
    // return simpleBox();
  }
}
</file>

<file path="packages/mix/example/lib/api/widgets/hbox/icon_label_chip.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../../helpers.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final flexStyle = FlexBoxStyler()
        .mainAxisSize(MainAxisSize.min)
        .spacing(4)
        .color(Colors.cyan.shade50)
        .paddingX(10)
        .paddingY(4)
        .borderRounded(99)
        .borderAll(color: Colors.cyan.shade600, width: 2);

    final iconStyle = IconStyler()
        .icon(Icons.ac_unit_rounded)
        .color(Colors.cyan.shade600)
        .size(18);
    final textStyle = TextStyler()
        .fontSize(16)
        .fontWeight(FontWeight.w500)
        .color(Colors.cyan.shade700);

    return RowBox(
      style: flexStyle,
      children: [
        StyledIcon(style: iconStyle),
        StyledText('Snow', style: textStyle),
      ],
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/widgets/icon/styled_icon.dart">
import '../../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final style =
        IconStyler() //
            .size(30)
            .color(Colors.blueAccent);

    return StyledIcon(icon: Icons.format_paint_rounded, style: style);
  }
}
</file>

<file path="packages/mix/example/lib/api/widgets/text/styled_text.dart">
import '../../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final style = TextStyler()
        .fontSize(20)
        .fontWeight(FontWeight.w700)
        .uppercase()
        .color(Colors.red);

    return StyledText('I love Mix', style: style);
  }
}
</file>

<file path="packages/mix/example/lib/api/widgets/vbox/card_layout.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../../helpers.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final flexStyle = FlexBoxStyler()
        .mainAxisSize(MainAxisSize.min)
        .spacing(4)
        .crossAxisAlignment(CrossAxisAlignment.start)
        .mainAxisAlignment(MainAxisAlignment.spaceBetween)
        .color(Colors.grey.shade50)
        .paddingX(12)
        .paddingY(10)
        .borderRounded(10)
        .borderAll(color: Colors.blueGrey.shade400, width: 1)
        .height(150)
        .width(120)
        .shadowOnly(color: Colors.black12, blurRadius: 10);

    final iconStyle = IconStyler()
        .icon(Icons.piano_outlined)
        .color(Colors.blueGrey.shade600)
        .size(20);

    final textStyle = TextStyler()
        .fontSize(16)
        .fontWeight(FontWeight.w500)
        .color(Colors.blueGrey.shade600);

    return ColumnBox(
      style: flexStyle,
      children: [
        StyledIcon(style: iconStyle),
        StyledText('Musician', style: textStyle),
      ],
    );
  }
}
</file>

<file path="packages/mix/example/lib/api/widgets/zbox/layered_boxes.dart">
import '../../../helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final flexStyle = StackBoxStyler(
      constraints: BoxConstraintsMix.height(100).width(100),
      stackAlignment: Alignment.bottomCenter,
    );

    final boxStyle = BoxStyler()
        .color(Colors.deepOrange)
        .height(100)
        .width(100);

    return ZBox(
      style: flexStyle,
      children: [
        Box(style: boxStyle),
        Box(
          style: BoxStyler().color(Colors.grey.shade300).height(50).width(100),
        ),
        Box(
          style: BoxStyler()
              .color(Colors.black)
              .height(15)
              .width(100)
              .wrapAlign(Alignment.center),
        ),
        Box(
          style: BoxStyler()
              .color(Colors.grey.shade100)
              .height(100)
              .width(100)
              .borderAll(color: Colors.black, width: 20)
              .wrapScale(x: 0.50, y: 0.50),
        ),
      ],
    );
  }
}
</file>

<file path="packages/mix/example/lib/components/chip_button.dart">
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mix/mix.dart';

final chipButtonLabel = TextStyler(
  style: TextStyleMix(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
  textAlign: TextAlign.center,
);

final chipButtonContainer = BoxStyler()
    .height(40)
    .width(120)
    .color(Colors.blue)
    .borderRounded(20)
    .onHovered(BoxStyler().color(Colors.blue.shade700))
    .onSelected(BoxStyler().color(Colors.black))
    .alignment(Alignment.center)
    .wrap(WidgetModifierConfig.defaultText(chipButtonLabel))
    .animate(AnimationConfig.easeInOut(300.ms));

class FilterChipButton extends StatefulWidget {
  const FilterChipButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  State<FilterChipButton> createState() => _FilterChipButtonState();
}

class _FilterChipButtonState extends State<FilterChipButton> {
  late final WidgetStatesController controller;

  @override
  void initState() {
    super.initState();
    controller = WidgetStatesController();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.selected = widget.selected;
    });
  }

  @override
  void didUpdateWidget(FilterChipButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      controller.selected = widget.selected;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onPress: widget.onPressed,
      controller: controller,
      child: Box(style: chipButtonContainer, child: Text(widget.label)),
    );
  }
}
</file>

<file path="packages/mix/example/lib/components/custom_scaffold.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

final scaffoldContainer = FlexBoxStyler()
    .mainAxisSize(MainAxisSize.max)
    .crossAxisAlignment(CrossAxisAlignment.stretch)
    .mainAxisAlignment(MainAxisAlignment.start)
    .color(Colors.white);

final appHeaderContainer = BoxStyler()
    .height(80)
    .color(Colors.black)
    .paddingAll(16)
    .alignment(Alignment.center)
    .wrapDefaultTextStyle(
      TextStyleMix()
          .fontSize(20)
          .fontWeight(FontWeight.bold)
          .color(Colors.white),
    );

final scaffoldBodyContainer = BoxStyler()
    .color(Colors.grey.shade50)
    .padding(EdgeInsetsMix.all(16));

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.appBar, required this.body});

  final Widget? appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return ColumnBox(
      style: scaffoldContainer,
      children: [
        if (appBar != null) appBar!,
        Expanded(
          child: SizedBox(width: double.infinity, child: body),
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Box(style: appHeaderContainer, child: Text(title));
  }
}
</file>

<file path="packages/mix/example/lib/components/tokens.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

// Basic color tokens
final $primary = ColorToken('primary');
final $surface = ColorToken('surface');
final $surfaceVariant = ColorToken('surface.variant');
final $onPrimary = ColorToken('on.primary');
final $onSurface = ColorToken('on.surface');
final $onSurfaceVariant = ColorToken('on.surface.variant');

// Basic spacing tokens
final $space = SpaceToken('space');
final $spaceSmall = SpaceToken('space.small');
final $spaceLarge = SpaceToken('space.large');

// Basic radius token
final $radius = RadiusToken('radius');

// Token maps for use with MixScope
final exampleColorTokens = <ColorToken, Color>{
  $primary: Colors.blue,
  $surface: Colors.grey.shade200,
  $surfaceVariant: Colors.grey.shade300,
  $onPrimary: Colors.white,
  $onSurface: Colors.grey.shade800,
  $onSurfaceVariant: Colors.grey.shade600,
};

final exampleSpaceTokens = <SpaceToken, double>{
  $spaceSmall: 8.0,
  $space: 16.0,
  $spaceLarge: 24.0,
};

final exampleRadiusTokens = <RadiusToken, Radius>{
  $radius: const Radius.circular(20),
};
</file>

<file path="packages/mix/example/lib/docs/guides/animations.dart">
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers.dart';

void main() {
  runMixApp(const Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        ScaleAnimation(),
        HoverAnimation(),
        CompressExpandAnimation(),
        HeartKeyframeAnimation(),
      ],
    );
  }
}

// 1

class ScaleAnimation extends StatefulWidget {
  const ScaleAnimation({super.key});

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation> {
  bool appear = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        appear = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.black)
        .height(100)
        .width(100)
        .borderRounded(10)
        .scale(appear ? 1 : 0.1) // state-based
        .animate(AnimationConfig.easeInOut(1.s));

    return Box(style: style);
  }
}

// 2

class HoverAnimation extends StatelessWidget {
  const HoverAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.black)
        .height(100)
        .width(100)
        .borderRounded(10)
        .scale(1)
        .onHovered(BoxStyler().color(Colors.blue).scale(1.5))
        .animate(AnimationConfig.spring(800.ms));

    return Box(style: style);
  }
}

// 3

enum AnimationPhases { initial, compress, expanded }

class CompressExpandAnimation extends StatefulWidget {
  const CompressExpandAnimation({super.key});

  @override
  State<CompressExpandAnimation> createState() =>
      _CompressExpandAnimationState();
}

class _CompressExpandAnimationState extends State<CompressExpandAnimation> {
  final _isExpanded = ValueNotifier(false);

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = BoxStyler()
        .color(Colors.deepPurple)
        .height(100)
        .width(100)
        .borderRounded(40)
        .phaseAnimation(
          trigger: _isExpanded,
          phases: AnimationPhases.values,
          styleBuilder: (phase, style) => switch (phase) {
            AnimationPhases.initial => style.scale(1),
            AnimationPhases.compress =>
              style.scale(0.75).color(Colors.red.shade800),
            AnimationPhases.expanded =>
              style.scale(1.25).borderRounded(20).color(Colors.yellow.shade300),
          },
          configBuilder: (phase) => switch (phase) {
            AnimationPhases.initial =>
              CurveAnimationConfig.springWithDampingRatio(800.ms, ratio: 0.3),
            AnimationPhases.compress => CurveAnimationConfig.decelerate(200.ms),
            AnimationPhases.expanded => CurveAnimationConfig.decelerate(100.ms),
          },
        );
    return Pressable(
      onPress: () {
        _isExpanded.value = !_isExpanded.value;
      },
      child: Box(style: style),
    );
  }
}

// 4

class HeartKeyframeAnimation extends StatefulWidget {
  const HeartKeyframeAnimation({super.key});

  @override
  State<HeartKeyframeAnimation> createState() => _HeartKeyframeAnimationState();
}

class _HeartKeyframeAnimationState extends State<HeartKeyframeAnimation> {
  final _trigger = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final style = IconStyler()
        .color(Colors.red)
        .size(80)
        .keyframeAnimation(
          trigger: _trigger,
          timeline: [
            KeyframeTrack<Color>(
              'color',
              [
                Keyframe.linear(Colors.blue.shade100, 100.ms),
                Keyframe.elasticOut(Colors.blue.shade400, 800.ms),
                Keyframe.elasticOut(Colors.green.shade100, 800.ms),
              ],
              initial: Colors.red.shade100,
              tweenBuilder: ColorTween.new,
            ),
            KeyframeTrack<double>('scale', [
              Keyframe.linear(1.0, 360.ms),
              Keyframe.elasticOut(1.5, 800.ms),
              Keyframe.elasticOut(1.0, 800.ms),
            ], initial: 1.0),
            KeyframeTrack<double>('verticalOffset', [
              Keyframe.linear(0.0, 100.ms),
              Keyframe.easeIn(20.0, 150.ms),
              Keyframe.elasticOut(-60.0, 1000.ms),
              Keyframe.elasticOut(0.0, 800.ms),
            ], initial: 0.0),
            KeyframeTrack<double>('verticalStretch', [
              Keyframe.ease(1.0, 100.ms),
              Keyframe.ease(0.6, 150.ms),
              Keyframe.ease(1.5, 100.ms),
              Keyframe.ease(1.05, 150.ms),
              Keyframe.ease(1.0, 880.ms),
              Keyframe.ease(0.8, 100.ms),
              Keyframe.ease(1.04, 400.ms),
              Keyframe.ease(1.0, 220.ms),
            ], initial: 1.0),
            KeyframeTrack<double>('angle', [
              Keyframe.easeIn(0.0, 580.ms),
              Keyframe.easeIn(16.0 * (pi / 180), 125.ms),
              Keyframe.easeIn(-16.0 * (pi / 180), 125.ms),
              Keyframe.easeIn(16.0 * (pi / 180), 125.ms),
              Keyframe.easeIn(0.0, 125.ms),
            ], initial: 0.0),
          ],
          styleBuilder: (values, style) {
            final scale = values.get('scale');
            final verticalOffset = values.get('verticalOffset');
            final verticalStretch = values.get('verticalStretch');
            final angle = values.get('angle');

            return style.wrapTransform(
              Matrix4.identity()
                ..scaleByDouble(scale, scale, scale, 1.0)
                ..translateByDouble(0, verticalOffset, 0, 1)
                ..scaleByDouble(1, verticalStretch, 1, 1)
                ..rotateZ(angle),
            );
          },
        );
    return Pressable(
      onPress: () {
        _trigger.value++;
      },
      child: StyledIcon(icon: CupertinoIcons.heart_fill, style: style),
    );
  }
}
</file>

<file path="packages/mix/example/lib/docs/guides/directives.dart">
import 'package:example/helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(const Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledText('hello world', style: TextStyler().uppercase());
  }
}
</file>

<file path="packages/mix/example/lib/docs/guides/styling.dart">
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  // 1
  final style = BoxStyler()
      .width(240)
      .height(100)
      .color(Colors.blue)
      .borderRounded(12);

  // 2
  final base = BoxStyler()
      .paddingX(16)
      .paddingY(8)
      .borderRounded(8)
      .color(Colors.black)
      .wrapDefaultTextStyle(
        TextStyleMix().color(Colors.deepOrange).fontWeight(FontWeight.bold),
      );

  final solid = base.color(Colors.blue);

  final soft = base
      .color(Colors.blue.shade100)
      .wrapDefaultTextStyle(TextStyleMix().color(Colors.blue));

  // 3
  final button = BoxStyler()
      .color(Colors.blue)
      .onHovered(BoxStyler().color(Colors.blue.shade700))
      .onDark(BoxStyler().color(Colors.blue.shade200));
}
</file>

<file path="packages/mix/example/lib/docs/guides/variants.dart">
// ignore_for_file: unused_local_variable

import 'package:example/helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  // 1
  final style = BoxStyler()
      .color(Colors.red)
      .height(100)
      .width(100)
      .borderRounded(10)
      .onHovered(BoxStyler().color(Colors.blue));

  // 2
  final styleA = BoxStyler()
      .color(Colors.red)
      .height(100)
      .width(100)
      .borderRounded(10)
      .onHovered(BoxStyler().color(Colors.blue).width(200));

  final styleB = styleA.onHovered(BoxStyler().color(Colors.green));

  final result = BoxStyler()
      .color(Colors.green)
      .height(100)
      .width(200)
      .borderRounded(10);

  // 3
  final hoverStyle = BoxStyler()
      .onDark(BoxStyler().color(Colors.blue))
      .onLight(BoxStyler().color(Colors.green));

  final nestedStyle = BoxStyler()
      .color(Colors.red)
      .height(100)
      .width(100)
      .borderRounded(10)
      .onHovered(hoverStyle);

  runMixApp(
    Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        Box(style: style),
        Box(style: styleA),
        Box(style: styleB),
        Box(style: nestedStyle),
      ],
    ),
  );
}
</file>

<file path="packages/mix/example/lib/docs/overview/comparison.dart">
import 'package:example/helpers.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runMixApp(
    const Row(
      spacing: 16,
      mainAxisSize: MainAxisSize.min,
      children: [CustomMixWidget(), CustomWidget()],
    ),
  );
}

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
              .color(Colors.grey.shade700)
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
              .color(Colors.cyan.shade300)
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

class CustomWidget extends StatefulWidget {
  const CustomWidget({super.key});

  @override
  CustomWidgetState createState() => CustomWidgetState();
}

class CustomWidgetState extends State<CustomWidget> {
  bool _isHover = false;

  final _curve = Curves.linear;
  final _duration = const Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    final backgroundColor = isDark ? Colors.cyan : Colors.blue;
    final textColor = isDark ? Colors.black : Colors.white;
    final borderRadius = BorderRadius.circular(10);

    final onHoverTextColor = isDark
        ? Colors.grey.shade700
        : Colors.grey.shade200;

    final onHoverBgColor = isDark ? Colors.cyan.shade300 : Colors.blue.shade300;

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
            padding: _isHover
                ? const EdgeInsets.all(10)
                : const EdgeInsets.all(20),
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
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: _isHover ? onHoverTextColor : textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
</file>

<file path="packages/mix/example/lib/docs/overview/getting_started.dart">
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

final primaryCard = BoxStyler().color(Colors.blue).borderRounded(12);

final box = Box(style: primaryCard, child: StyledText('Primary'));
final box2 = Box(
  style: primaryCard.color(Colors.green),
  child: StyledText('Success'),
);
</file>

<file path="packages/mix/example/lib/docs/overview/index.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers.dart';

void main() {
  runMixApp(const Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return MixScope(
      tokens: tokenDefinitions,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Box(style: boxStyle),
          StyledText('Hello, World!', style: textStyle),
          Box(style: buttonStyle),
          Box(style: tokenStyle),
        ],
      ),
    );
  }
}

// 1
final boxStyle = BoxStyler()
    .height(100)
    .width(100)
    .color(Colors.purple)
    .borderRounded(10);

final textStyle = TextStyler()
    .fontSize(20)
    .fontWeight(FontWeight.bold)
    .color(Colors.black);

// 2
final buttonStyle = BoxStyler()
    .height(50)
    .borderRounded(25)
    .color(Colors.blue)
    .onHovered(BoxStyler().color(Colors.blue.shade700))
    .onDark(BoxStyler().color(Colors.blue.shade200));

// 3
final $primaryColor = ColorToken('primary');
final $borderRadius = RadiusToken('borderRadius');

final tokenDefinitions = <MixToken, Object>{
  $primaryColor: Colors.blue,
  $borderRadius: Radius.circular(8),
};

final tokenStyle = BoxStyler()
    .color($primaryColor())
    .width(100)
    .height(100)
    .borderRadius(BorderRadiusGeometryMix.all($borderRadius()));
</file>

<file path="packages/mix/example/lib/docs/overview/utility_first.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  // 1
  // ignore: unused_local_variable
  final boxStyle = BoxStyler()
      .width(100)
      .paddingAll(10)
      .alignment(Alignment.center)
      .color(Colors.red);

  // 2
  BoxStyler().alignment(Alignment.centerRight);

  BoxStyler().paddingAll(16);

  BoxStyler().paddingX(12).paddingY(8);
  BoxStyler().paddingOnly(horizontal: 12, vertical: 8);

  // 4
  BoxStyler().borderAll(color: Colors.red);
  BoxStyler().borderTop(color: Colors.red, width: 2);

  // 5
  BoxStyler borderTop(Color color) => BoxStyler().borderTop(color: color);
  borderTop(Colors.red);
  // ignore: unused_local_variable
  final style = borderTop(Colors.red).paddingAll(8);

  // 6
  BoxStyler borderRedTop() => BoxStyler().borderRedTop();

  borderRedTop();
}

extension on BoxStyler {
  BoxStyler borderRedTop() => borderTop(color: Colors.red);
}
</file>

<file path="packages/mix/example/lib/docs/widgets/box.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  Box(
    style: BoxStyler()
        .width(100)
        .height(100)
        .color(Colors.blue)
        .borderRounded(8),
    child: Text('Styled Box'),
  );
}
</file>

<file path="packages/mix/example/lib/docs/widgets/flexbox.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  // 1.
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

  // 2.
  RowBox(
    style: FlexBoxStyler()
        .color(Colors.blue)
        .mainAxisAlignment(MainAxisAlignment.spaceBetween),
    children: [
      //...
    ],
  );

  // 3.
  ColumnBox(
    style: FlexBoxStyler()
        .color(Colors.blue)
        .mainAxisAlignment(MainAxisAlignment.spaceBetween),
    children: [
      //...
    ],
  );
}
</file>

<file path="packages/mix/example/lib/docs/widgets/icon.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  // 1.
  StyledIcon(icon: Icons.star, style: IconStyler().color(Colors.blue).size(30));
}
</file>

<file path="packages/mix/example/lib/docs/widgets/image.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  // 1.
  StyledImage(
    image: AssetImage('assets/image.jpg'),
    style:
        ImageStyler() //
            .width(152)
            .height(152)
            .fit(BoxFit.cover),
  );
}
</file>

<file path="packages/mix/example/lib/docs/widgets/pressable.dart">
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  // 1.
  Pressable(onPress: () => print('Pressed!'), child: StyledText('Press Me'));

  // 2.
  Pressable(
    onPress: () => print('Pressed'),
    onLongPress: () => print('Long pressed'),
    onFocusChange: (focused) => print('Focus: $focused'),
    autofocus: true,
    child: StyledText('Interactive Button'),
  );

  // 3.
  Pressable(
    enabled: false,
    onPress: () => print('This won\'t be called'),
    child: StyledText('Disabled Button'),
  );

  // 4.
  PressableBox(
    style: BoxStyler().color(Colors.blue).paddingAll(16).borderRounded(8),
    onPress: () => print('PressableBox pressed'),
    child: StyledText('Styled Button'),
  );
}
</file>

<file path="packages/mix/example/lib/docs/widgets/stylewidgets.dart">
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  // 1
  final boxStyle = BoxStyler().size(100, 100).color(Colors.blue);

  Box(style: boxStyle);

  // 2
  final flexStyle = FlexBoxStyler()
      .mainAxisAlignment(MainAxisAlignment.spaceBetween)
      .color(Colors.blue)
      .direction(Axis.vertical);

  FlexBox(
    style: flexStyle,
    children: [Text('Item 1'), Text('Item 2'), Text('Item 3')],
  );

  // 3
  final style = TextStyler().color(Colors.blue).fontSize(20);

  StyledText('Hello, World!', style: style);

  // 4
  final iconStyle = IconStyler().color(Colors.blue).size(30);

  StyledIcon(icon: Icons.ac_unit, style: iconStyle);

  // 5
  final imageStyle = ImageStyler().width(200).height(150);

  StyledImage(
    image: NetworkImage('https://example.com/image.png'),
    style: imageStyle,
  );

  // 6
  final pressableStyle = BoxStyler().color(Colors.blue).size(100, 100);

  PressableBox(
    onPress: () => print('Pressed!'),
    style: pressableStyle,
    child: Text('Tap me'),
  );
}
</file>

<file path="packages/mix/example/lib/examples/okinawa.card.dart">
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(home: DemoApp());
  }
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: Center(child: OkinawaCard()),
    );
  }
}

class OkinawaCard extends StatelessWidget {
  const OkinawaCard({super.key});

  @override
  Widget build(BuildContext context) {
    final boxStyle = BoxStyler()
        .height(200)
        .width(200)
        .paddingAll(8)
        .alignment(Alignment.bottomCenter)
        .borderRounded(10)
        .backgroundImageUrl(
          'https://images.pexels.com/photos/5472603/pexels-photo-5472603.jpeg',
          fit: BoxFit.cover,
        )
        .borderAll(
          color: Colors.white,
          width: 6,
          strokeAlign: BorderSide.strokeAlignOutside,
        )
        .color(Colors.blueGrey.shade50)
        .shadowOnly(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 100,
        );

    final columnBoxStyle = FlexBoxStyler()
        .paddingAll(8)
        .width(double.infinity)
        .color(Colors.black.withValues(alpha: 0.1))
        .mainAxisSize(MainAxisSize.min)
        .crossAxisAlignment(CrossAxisAlignment.start);

    final titleStyle = TextStyler()
        .color(Colors.white)
        .fontWeight(FontWeight.bold)
        .fontSize(16);

    final subtitleStyle = TextStyler().color(Colors.white70).fontSize(14);

    return Box(
      style: boxStyle,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: ColumnBox(
            style: columnBoxStyle,
            children: [titleStyle('Okinawa'), subtitleStyle('Japan')],
          ),
        ),
      ),
    );
  }
}
</file>

<file path="packages/mix/example/lib/helpers.dart">
import 'package:flutter/material.dart';

class _ExampleApp extends StatelessWidget {
  const _ExampleApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }
}

void runMixApp(Widget child) {
  runApp(_ExampleApp(child: child));
}
</file>

<file path="packages/mix/example/lib/main.dart">
import 'package:flutter/material.dart';

import 'components/custom_scaffold.dart';
import 'components/chip_button.dart';
import 'api/animation/implicit.curved.hover.dart' as hover_scale;
import 'api/animation/implicit.curved.scale.dart' as auto_scale;
import 'api/animation/phase.compress.dart' as tap_phase;
import 'api/animation/keyframe.switch.dart' as animated_switch;
import 'api/animation/implicit.spring.translate.dart' as spring_anim;
import 'api/context_variants/disabled.dart' as disabled;
import 'api/context_variants/focused.dart' as focused;
import 'api/context_variants/hovered.dart' as hovered;
import 'api/context_variants/on_dark_light.dart' as dark_light;
import 'api/context_variants/pressed.dart' as pressed;
import 'api/context_variants/selected.dart' as selected;
import 'api/context_variants/selected_toggle.dart' as selected_toggle;
import 'api/context_variants/responsive_size.dart' as responsive_size;
// Animation examples have different class names, will be added separately
import 'api/design_tokens/theme_tokens.dart' as theme_tokens;
// Import all example widgets
import 'api/widgets/box/simple_box.dart' as simple_box;
import 'api/widgets/box/gradient_box.dart' as gradient_box;
import 'api/widgets/hbox/icon_label_chip.dart' as icon_label_chip;
import 'api/widgets/icon/styled_icon.dart' as styled_icon;
import 'api/widgets/text/styled_text.dart' as styled_text;
import 'api/widgets/vbox/card_layout.dart' as card_layout;
import 'api/widgets/zbox/layered_boxes.dart' as layered_boxes;
// Text examples
import 'api/text/text_directives.dart' as text_directives;
// Gradient examples
import 'api/gradients/gradient_linear.dart' as gradient_linear;
import 'api/gradients/gradient_radial.dart' as gradient_radial;
import 'api/gradients/gradient_sweep.dart' as gradient_sweep;

void main() {
  runApp(const MixExampleApp());
}

class MixExampleApp extends StatelessWidget {
  const MixExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      pageRouteBuilder:
          <T extends Object?>(RouteSettings settings, WidgetBuilder builder) =>
              PageRouteBuilder<T>(
                settings: settings,
                pageBuilder: (context, animation, _) => builder(context),
              ),
      home: const ExampleNavigator(),
      title: 'Mix Examples',
      color: const Color(0xFF2196F3),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExampleNavigator extends StatefulWidget {
  const ExampleNavigator({super.key});

  @override
  State<ExampleNavigator> createState() => _ExampleNavigatorState();
}

class _ExampleNavigatorState extends State<ExampleNavigator> {
  String _selectedCategory = 'All';

  final List<ExampleItem> _examples = [
    // Widget Examples
    ExampleItem(
      title: 'Box - Basic',
      description: 'Simple red box with rounded corners',
      category: 'Widgets',
      widget: const simple_box.Example(),
    ),
    ExampleItem(
      title: 'Box - Gradient',
      description: 'Box with gradient and shadow',
      category: 'Widgets',
      widget: const gradient_box.Example(),
    ),
    ExampleItem(
      title: 'HBox - Horizontal Layout',
      description: 'Horizontal flex container with icon and text',
      category: 'Widgets',
      widget: const icon_label_chip.Example(),
    ),
    ExampleItem(
      title: 'VBox - Vertical Layout',
      description: 'Vertical flex container with styled elements',
      category: 'Widgets',
      widget: const card_layout.Example(),
    ),
    ExampleItem(
      title: 'ZBox - Stack Layout',
      description: 'Stacked boxes with different alignments',
      category: 'Widgets',
      widget: const layered_boxes.Example(),
    ),
    ExampleItem(
      title: 'Icon - Styled',
      description: 'Styled icon with custom size and color',
      category: 'Widgets',
      widget: const styled_icon.Example(),
    ),
    ExampleItem(
      title: 'Text - Styled',
      description: 'Styled text with custom typography',
      category: 'Widgets',
      widget: const styled_text.Example(),
    ),
    ExampleItem(
      title: 'Text - Directives',
      description:
          'Text transformations: uppercase, lowercase, capitalize, etc.',
      category: 'Widgets',
      widget: const text_directives.Example(),
    ),

    // Context Variants
    ExampleItem(
      title: 'Hover State',
      description: 'Box that changes color on hover',
      category: 'Context Variants',
      widget: const hovered.Example(),
    ),
    ExampleItem(
      title: 'Press State',
      description: 'Box that changes color when pressed',
      category: 'Context Variants',
      widget: const pressed.Example(),
    ),
    ExampleItem(
      title: 'Focus State',
      description: 'Boxes that change color when focused',
      category: 'Context Variants',
      widget: const focused.Example(),
    ),
    ExampleItem(
      title: 'Selected State',
      description: 'Box that toggles selected state',
      category: 'Context Variants',
      widget: const selected.Example(),
    ),
    ExampleItem(
      title: 'Disabled State',
      description: 'Disabled box with grey color',
      category: 'Context Variants',
      widget: const disabled.Example(),
    ),
    ExampleItem(
      title: 'Dark/Light Theme',
      description: 'Boxes that adapt to theme changes',
      category: 'Context Variants',
      widget: const dark_light.Example(),
    ),
    ExampleItem(
      title: 'Selected Toggle',
      description: 'Beautiful toggle button with selected state',
      category: 'Context Variants',
      widget: const selected_toggle.Example(),
    ),
    ExampleItem(
      title: 'Responsive Size',
      description: 'Dynamic sizing based on screen width',
      category: 'Context Variants',
      widget: const responsive_size.Example(),
    ),

    // Gradients
    ExampleItem(
      title: 'Linear Gradient',
      description: 'Beautiful purple-to-pink gradient with shadow',
      category: 'Gradients',
      widget: const gradient_linear.Example(),
    ),
    ExampleItem(
      title: 'Radial Gradient',
      description: 'Orange radial gradient with focal points',
      category: 'Gradients',
      widget: const gradient_radial.Example(),
    ),
    ExampleItem(
      title: 'Sweep Gradient',
      description: 'Colorful sweep gradient creating rainbow effect',
      category: 'Gradients',
      widget: const gradient_sweep.Example(),
    ),

    // Design Tokens
    ExampleItem(
      title: 'Design Tokens',
      description: 'Using design tokens for consistent styling',
      category: 'Design System',
      widget: const theme_tokens.Example(),
    ),
    // Animations
    ExampleItem(
      title: 'Hover Scale Animation',
      description: 'Box that scales up smoothly when hovered',
      category: 'Animations',
      widget: const hover_scale.Example(),
    ),
    ExampleItem(
      title: 'Auto Scale Animation',
      description: 'Box that automatically scales on load',
      category: 'Animations',
      widget: const auto_scale.Example(),
    ),
    ExampleItem(
      title: 'Tap Phase Animation',
      description: 'Multi-phase animation triggered by tap',
      category: 'Animations',
      widget: const tap_phase.BlockAnimation(),
    ),
    ExampleItem(
      title: 'Animated Switch',
      description: 'Toggle switch with phase-based animation',
      category: 'Animations',
      widget: const animated_switch.SwitchAnimation(),
    ),
    ExampleItem(
      title: 'Spring Animation',
      description: 'Bouncy spring physics animation',
      category: 'Animations',
      widget: const spring_anim.Example(),
    ),
  ];

  Widget _buildExampleCard(ExampleItem example) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            example.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          Text(
            example.description,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          Expanded(child: Center(child: example.widget)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All', ..._examples.map((e) => e.category).toSet()];
    final filteredExamples = _selectedCategory == 'All'
        ? _examples
        : _examples.where((e) => e.category == _selectedCategory).toList();

    return CustomScaffold(
      appBar: const CustomAppBar(title: 'Mix Examples'),
      body: Column(
        children: [
          // Category filter buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              children: categories.map((category) {
                final isSelected = _selectedCategory == category;

                return FilterChipButton(
                  label: category,
                  selected: isSelected,
                  onPressed: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          // Examples grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final example = filteredExamples[index];

                return _buildExampleCard(example);
              },
              itemCount: filteredExamples.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ExampleItem {
  final String title;
  final String description;
  final String category;
  final Widget widget;

  const ExampleItem({
    required this.title,
    required this.description,
    required this.category,
    required this.widget,
  });
}
</file>

<file path="packages/mix/example/test/widget_test.dart">
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const ExampleNavigator());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
}
</file>

</files>
