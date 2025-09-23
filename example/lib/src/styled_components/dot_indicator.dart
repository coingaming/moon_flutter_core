import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

class StyledDotIndicator extends StatefulWidget {
  const StyledDotIndicator({super.key});

  @override
  State<StyledDotIndicator> createState() => _StyledDotIndicatorState();
}

class _StyledDotIndicatorState extends State<StyledDotIndicator> {
  int _selectedDot = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          // Basic dot indicator - using simple props API
          _buildSection(
            'Basic Dot Indicator (Simple API)',
            MoonDotIndicator(
              selectedIndex: _selectedDot,
              count: 4,
              selectedColor: Colors.blue,
              unselectedColor: Colors.grey.shade300,
              dotSize: 8,
              spacing: 10,
              transitionDuration: const Duration(milliseconds: 250),
            ),
          ),
          const SizedBox(height: 32),

          // Interactive dot indicator with Mix API
          _buildSection(
            'Interactive Dot Indicator (Mix API)',
            MoonDotIndicator(
              selectedIndex: _selectedDot,
              count: 4,
              onDotTap: (index) => setState(() => _selectedDot = index),
              selectedDotStyle: BoxStyler()
                  .size(10, 10)
                  .borderRounded(5)
                  .color(Colors.purple)
                  .animate(AnimationConfig.spring(200.ms, bounce: 0.3)),
              unselectedDotStyle: BoxStyler()
                  .size(8, 8)
                  .borderRounded(4)
                  .color(Colors.purple.shade200)
                  .animate(AnimationConfig.spring(200.ms)),
            ),
          ),
          const SizedBox(height: 32),

          // Interactive with simple props
          _buildSection(
            'Interactive (Simple Props + Tap)',
            MoonDotIndicator(
              selectedIndex: _selectedDot,
              count: 4,
              onDotTap: (index) => setState(() => _selectedDot = index),
              selectedColor: Colors.deepOrange,
              unselectedColor: Colors.orange.shade200,
              dotSize: 10,
              transitionCurve: Curves.elasticOut,
            ),
          ),
          const SizedBox(height: 32),

          // Animated dot indicator with distance-based sizing
          _buildSection(
            'Animated Dot Indicator',
            MoonAnimatedDotIndicator(
              selectedIndex: _selectedDot,
              count: 4,
              onDotTap: (index) => setState(() => _selectedDot = index),
              showScale: true,
              showColorTransition: true,
            ),
          ),
          const SizedBox(height: 32),

          // Page indicator variant
          _buildSection(
            'Page Indicator',
            MoonPageIndicator(
              selectedIndex: _selectedDot,
              count: 4,
              onPageTap: (index) => setState(() => _selectedDot = index),
            ),
          ),
          const SizedBox(height: 32),

          // Number boxes to control selection
          RowBox(
            style: FlexBoxStyler()
                .mainAxisAlignment(MainAxisAlignment.center)
                .spacing(12),
            children: List.generate(4, (index) {
              return PressableBox(
                onPress: () => setState(() => _selectedDot = index),
                style: _numberBoxStyle(index == _selectedDot),
                child: Center(
                  child: StyledText(
                    '$index',
                    style: TextStyler()
                        .fontSize(14)
                        .fontWeight(FontWeight.w600)
                        .color(
                          index == _selectedDot ? Colors.white : Colors.purple,
                        ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 32),

          // Custom creative dot indicator
          _buildSection(
            'Creative Custom Indicator',
            RowBox(
              style: FlexBoxStyler()
                  .spacing(4)
                  .mainAxisAlignment(MainAxisAlignment.center),
              children: List.generate(4, (index) {
                final isSelected = index == _selectedDot;
                return PressableBox(
                  onPress: () => setState(() => _selectedDot = index),
                  style: BoxStyler()
                      .width(isSelected ? 32 : 8)
                      .height(8)
                      .borderRounded(4)
                      .color(
                        isSelected
                            ? Colors.deepPurple
                            : Colors.deepPurple.withValues(alpha: 0.3),
                      )
                      .animate(AnimationConfig.spring(300.ms, bounce: 0.2))
                      .onHovered(
                        BoxStyler()
                            .color(
                              isSelected
                                  ? Colors.deepPurple.shade700
                                  : Colors.deepPurple.withValues(alpha: 0.5),
                            )
                            .animate(AnimationConfig.easeInOut(150.ms)),
                      ),
                  child: const SizedBox.shrink(),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  BoxMix _numberBoxStyle(bool isSelected) => BoxStyler()
      .size(32, 32)
      .borderRounded(4)
      .color(isSelected ? Colors.purple : Colors.transparent)
      .borderAll(
        color: isSelected ? Colors.purple : Colors.purple.shade300,
        width: 2,
      )
      .animate(AnimationConfig.spring(200.ms, bounce: 0.15))
      .onHovered(
        BoxStyler()
            .color(isSelected ? Colors.purple.shade700 : Colors.purple.shade50)
            .animate(AnimationConfig.easeInOut(150.ms)),
      )
      .onPressed(
        BoxStyler().scale(0.9).animate(AnimationConfig.easeOut(100.ms)),
      );
}
