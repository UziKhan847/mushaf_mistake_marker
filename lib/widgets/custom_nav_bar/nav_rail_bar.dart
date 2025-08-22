import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/shared_preferences/providers.dart';

class NavRailBar extends ConsumerStatefulWidget {
  const NavRailBar({
    super.key,
    required this.iconColors,
    required this.pageController,
    //required this.onDestinationSelected,
    required this.iconLabels,
  });

  final PageController pageController;
  final List<Color> iconColors;
  final List<String> iconLabels;

  @override
  ConsumerState<NavRailBar> createState() => _NavRailBarState();
}

class _NavRailBarState extends ConsumerState<NavRailBar> {
  //final void Function(int)? onDestinationSelected;
  void onDestinationSelected(int index) {
    widget.pageController.jumpToPage(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final prefs = ref.read(sharedPrefsProv);

    final page = widget.pageController.hasClients
        ? widget.pageController.page
        : 0;

    return NavigationRail(
      onDestinationSelected: (value) {
        if (value < 4) {
          onDestinationSelected(value);
        }

        if (value == 4) {
          ref.read(isDualPageProv.notifier).update((state) {
            final isDualPage = !state;

            prefs.setBool('isDualPage', isDualPage);

            return isDualPage;
          });
        }
      },
      labelType: NavigationRailLabelType.all,
      selectedIndex: 0,
      indicatorColor: Colors.transparent,
      destinations: [
        for (int i = 0; i < 4; i++) ...{
          NavigationRailDestination(
            icon: Icon(Icons.wallet, color: widget.iconColors[i]),
            label: Text(widget.iconLabels[i]),
          ),
        },
        if (page == 0)
          NavigationRailDestination(
            icon: Icon(Icons.pageview),
            label: Text('Dual Page'),
          ),
      ],
    );
  }
}
