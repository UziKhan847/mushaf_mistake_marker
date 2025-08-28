import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/widgets/custom_flex.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_icons/dark_mode_icon.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_icons/dual_page_icon.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_icons/main_nav_bar_icon.dart';

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

  BorderRadius getBoxRadius(Orientation orientation) {
    final radius = Radius.circular(20);

    if (orientation == Orientation.portrait) {
      return BorderRadius.only(topLeft: radius, topRight: radius);
    }

    return BorderRadius.only(topLeft: radius, bottomLeft: radius);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, orientation) {
        final isPortrait = orientation == Orientation.portrait;

        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(context).navigationBarTheme.backgroundColor,
            borderRadius: getBoxRadius(orientation),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50), // Shadow color
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: CustomFlex(
            isReversed: true,
            mainAxisAlignment: isPortrait
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.start,
            children: [
              ...List.generate(4, (index) {
                final isSelected = page == index;

                return MainNavBarIcon(
                  index: index,
                  isSelected: isSelected,
                  onTap: () {
                    if (widget.pageController.hasClients) {
                      widget.pageController.jumpToPage(index);
                      setState(() {});
                    }
                  },
                );
              }),

              if (!isPortrait) ...[
                Container(
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color(0x09000000)
                      : const Color(0x10FFFFFF),
                  child: SingleChildScrollView(
                    child: Column(children: [DarkModeIcon(), DualPageIcon()]),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
