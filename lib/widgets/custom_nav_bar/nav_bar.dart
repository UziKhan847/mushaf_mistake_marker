import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  NavBar({
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
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      height: 55,
      indicatorColor: Colors.transparent,
      maintainBottomViewPadding: true,
      destinations: [
        for (int i = 0; i < 4; i++) ...{
          NavigationDestination(
            icon: Icon(Icons.wallet, color: iconColors[i]),
            label: iconLabels[i],
          ),
        },
      ],
    );
  }
}
