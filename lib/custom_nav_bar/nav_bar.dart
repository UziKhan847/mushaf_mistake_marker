import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/eraser.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/highlighter.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/index.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/account.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/dark_mode.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/dual_page.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/settings.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/edge_fade_gradient.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  final radius = Radius.circular(20);

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).colorScheme.surface;

    return LayoutBuilder(
      builder: (_, constraints) {
        final isPortrait = constraints.maxHeight > constraints.maxWidth;
        final Axis direction = isPortrait ? .horizontal : .vertical;

        return Material(
          elevation: 20,
          color: bgColor,
          clipBehavior: .hardEdge,
          child: SizedBox(
            height: isPortrait ? null : constraints.maxHeight,
            width: isPortrait ? constraints.maxWidth : null,
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: direction,
                  child: Flex(
                    spacing: 1,
                    direction: direction,
                    mainAxisSize: .min,
                    children: [
                      SizedBox(
                        height: isPortrait ? 34 : 52,
                        width: isPortrait ? 52 : 34,
                      ),
                      const AccountItem(),
                      const IndexItem(),
                      if (!isPortrait) DualPageItem(),
                      const HighlighterItem(),
                      const EraserItem(),
                      const DarkModeItem(),
                    ],
                  ),
                ),
                SizedBox(
                  height: isPortrait ? 38 : 42,
                  width: isPortrait ? 42 : 38,
                  child: ColoredBox(color: bgColor),
                ),
                EdgeFadeGradient(
                  isPortrait: isPortrait,
                  isStart: true,
                  bgColor: bgColor,
                  offset: 45,
                ),
                EdgeFadeGradient(
                  isPortrait: isPortrait,
                  isStart: false,
                  bgColor: bgColor,
                ),
                SettingsItem(isPortrait: isPortrait),
              ],
            ),
          ),
        );
      },
    );
  }
}
