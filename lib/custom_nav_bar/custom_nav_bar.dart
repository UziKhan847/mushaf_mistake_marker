import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar_item.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/sub_items/account_item.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/sub_items/dark_mode_item.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/sub_items/dual_page_item.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/sub_items/highlighter_item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int get page => widget.pageController.hasClients
      ? widget.pageController.page!.round()
      : 0;
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
          borderRadius: BorderRadius.only(
            topLeft: radius,
            topRight: isPortrait ? radius : Radius.zero,
            bottomLeft: isPortrait ? Radius.zero : radius,
          ),
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            height: isPortrait ? null : constraints.maxHeight,
            width: isPortrait ? constraints.maxWidth : null,
            child: SingleChildScrollView(
              scrollDirection: isPortrait ? Axis.horizontal : Axis.vertical,
              child: Flex(
                direction: isPortrait ? Axis.horizontal : Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(3, (index) {
                    final isSelected = page == index;

                    return NavBarItem(
                      iconLabel: switch (index) {
                        1 => 'Index',
                        2 => 'Index',
                        _ => 'Mushaf',
                      },
                      isSelected: isSelected,
                      onTap: () {
                        if (widget.pageController.hasClients) {
                          widget.pageController.jumpToPage(index);
                          setState(() {});
                        }
                      },
                      selectedAsset: switch (index) {
                        1 => MyFlutterApp.index,
                        2 => MyFlutterApp.settings,
                        _ => MyFlutterApp.mushaf,
                      },
                      unselectedAsset: switch (index) {
                        1 => MyFlutterApp.index_outlined,
                        2 => MyFlutterApp.settings_outlined,
                        _ => MyFlutterApp.mushaf_outlined,
                      },
                    );
                  }),

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
