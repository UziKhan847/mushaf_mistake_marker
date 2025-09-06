import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar_item.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/sub_items/dark_mode_item.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/sub_items/dual_page_item.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/sub_items/highlighter_item.dart';

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
  late int targetPage;
  late int mushafPage;

  final mainIconNames = ['mushaf', 'index', 'settings'];

  BorderRadius getBoxRadius(bool isPortrait) {
    final radius = Radius.circular(20);

    if (isPortrait) {
      return BorderRadius.only(topLeft: radius, topRight: radius);
    }

    return BorderRadius.only(topLeft: radius, bottomLeft: radius);
  }

  List<Widget> getChildren(bool isPortrait) {
    return [
      ...List.generate(3, (index) {
        final isSelected = page == index;

        return NavBarItem(
          iconName: mainIconNames[index],
          isSelected: isSelected,
          onTap: () {
            if (widget.pageController.hasClients) {
              widget.pageController.jumpToPage(index);
              setState(() {});
            }
          },
        );
      }),

      getSubIcons(isPortrait),
    ];
  }

  Widget getSubIcons(bool isPortrait) {
    return Container(
      color: const Color(0x10000000),
      child: Flex(
        direction: isPortrait ? Axis.horizontal : Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: [
          DarkModeItem(),
          if (!isPortrait) DualPageItem(),
          HighlighterItem(),
        ],
      ),
    );
  }

  Color lightenColor(bool isDarkMode, Color color, [double amount = 0.00]) {
    if (isDarkMode) {
      return color;
    }

    final hsl = HSLColor.fromColor(color);
    final newLightness = (hsl.lightness + amount).clamp(0, 1.0) as double;
    final newColor = hsl.withLightness(newLightness).toColor();
    return newColor;
  }

  @override
  Widget build(BuildContext context) {
    //final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).colorScheme.surface;

    return LayoutBuilder(
      builder: (_, constraints) {
        final isPortrait = constraints.maxHeight > constraints.maxWidth;

        return Material(
          elevation: 20,
          color: bgColor,
          borderRadius: getBoxRadius(isPortrait),
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            height: isPortrait ? null : constraints.maxHeight,
            width: isPortrait ? constraints.maxWidth : null,
            //clipBehavior: Clip.hardEdge,
            //decoration: BoxDecoration(
            //color: Theme.of(context).colorScheme.surface,
            //borderRadius: getBoxRadius(isPortrait),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withAlpha(50),
            //     spreadRadius: 2,
            //     blurRadius: 7,
            //     offset: Offset(0, 0),
            //   ),
            // ],
            //),
            child: SingleChildScrollView(
              scrollDirection: isPortrait ? Axis.horizontal : Axis.vertical,
              child: Flex(
                direction: isPortrait ? Axis.horizontal : Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: getChildren(isPortrait),
              ),
            ),
          ),
        );
      },
    );
  }
}
