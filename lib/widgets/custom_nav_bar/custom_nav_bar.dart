import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/nav_bar.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/nav_rail_bar.dart';

class CustomNavBar extends StatelessWidget {
  CustomNavBar({super.key, required this.pageController});

  final PageController pageController;

  final List<Color> colors = [
    Colors.amberAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.redAccent,
  ];

  final List<String> iconLabels = ['Mushaf', 'Page Info', 'Index', 'More'];

  void Function(int)? onDestinationSelected(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, orientation) {
        return orientation == Orientation.portrait
            ? NavBar(
                iconColors: colors,
                pageController: pageController,
                onDestinationSelected: onDestinationSelected,
                iconLabels: iconLabels
              )
            : NavRailBar(
                iconColors: colors,
                pageController: pageController,
                onDestinationSelected: onDestinationSelected,
                iconLabels: iconLabels
              );
      },
    );
  }
}
