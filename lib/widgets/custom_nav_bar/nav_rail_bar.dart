import 'package:flutter/material.dart';

class NavRailBar extends StatelessWidget {
  NavRailBar({
    super.key,
    required this.iconColors,
    required this.pageController,
    required this.onDestinationSelected,
    required this.iconLabels,
  });

  final PageController pageController;
  final List<Color> iconColors;
  final List<String> iconLabels;
  final void Function(int)? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      onDestinationSelected: onDestinationSelected,
      labelType: NavigationRailLabelType.all,
      selectedIndex: 0,
      indicatorColor: Colors.transparent,
      destinations: [
        for (int i = 0; i < 4; i++) ...{
          NavigationRailDestination(
            icon: Icon(Icons.wallet, color: iconColors[i]),
            label: Text(iconLabels[i]),
          ),
        },
      ],
    );
  }
}
