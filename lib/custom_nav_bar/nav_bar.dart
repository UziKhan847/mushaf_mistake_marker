import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/highlighter.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/index.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/mushaf.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/settings.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/account.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/dark_mode.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_items/dual_page.dart';

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

        return Material(
          elevation: 20,
          color: bgColor,
          // borderRadius: .only(
          //   topLeft: radius,
          //   topRight: isPortrait ? radius : .zero,
          //   bottomLeft: isPortrait ? .zero : radius,
          // ),
          clipBehavior: .hardEdge,
          child: SizedBox(
            height: isPortrait ? null : constraints.maxHeight,
            width: isPortrait ? constraints.maxWidth : null,
            child: SingleChildScrollView(
              scrollDirection: isPortrait ? .horizontal : .vertical,
              child: Flex(
                direction: isPortrait ? .horizontal : .vertical,
                mainAxisSize: .min,
                children: [
                  MushafItem(),
                  IndexItem(),
                  SettingsItem(),
                  AccountItem(),
                  DarkModeItem(),
                  if (!isPortrait) DualPageItem(),
                  HighlighterItem(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
