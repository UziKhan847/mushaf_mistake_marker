import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mushaf_mistake_marker/variables.dart';
import 'package:mushaf_mistake_marker/widgets/custom_flex.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/main_nav_bar_icon.dart';

class CustomNavBar extends StatefulWidget {
  CustomNavBar({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int get page => widget.pageController.hasClients
      ? widget.pageController.page!.toInt()
      : 0;

  late final List<MainNavBarIcon> items = navItems.map((data) {
    return MainNavBarIcon(
      selectedIcon: SvgPicture.asset(
        data.selectedAsset,
        width: 24,
        height: 24,
        semanticsLabel: '${data.label} selected',
      ),
      unSelectedIcon: SvgPicture.asset(
        data.unSelectedAsset,
        width: 24,
        height: 24,
        semanticsLabel: '${data.label} unselected',
      ),
      labelText: data.label,
    );
  }).toList();

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
          decoration: BoxDecoration(
            color: Color(0xFFFEF9F3),
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
                final item = items[index];
                final isSelected = page == index;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.pageController.hasClients) {
                        widget.pageController.jumpToPage(index);
                        setState(() {});
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isSelected ? item.selectedIcon : item.unSelectedIcon,
                        Text(
                          item.labelText,
                          style: TextStyle(
                            fontSize: 10,
                            color: isSelected ? Color(0xFFaf955e) : Colors.grey,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
