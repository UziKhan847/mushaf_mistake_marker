import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  NavBar({
    super.key,
    required this.iconColors,
    required this.pageController,
    //required this.onDestinationSelected,
    required this.iconLabels,
  });

  final PageController pageController;
  final List<Color> iconColors;
  final List<String> iconLabels;
  //final void Function(int)? onDestinationSelected;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  void Function(int)? onDestinationSelected(int index) {
    widget.pageController.jumpToPage(index);
    setState(() {});

    return null;
  }

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
            icon: Icon(Icons.wallet, color: widget.iconColors[i]),
            label: widget.iconLabels[i],
          ),
        },
      ],
    );
  }
}
