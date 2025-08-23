import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';
import 'package:mushaf_mistake_marker/providers/theme_provider.dart';
import 'package:mushaf_mistake_marker/widgets/custom_flex.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/main_nav_bar_icon.dart';

class CustomNavBar extends ConsumerStatefulWidget {
  const CustomNavBar({super.key, required this.pageController});

  final PageController pageController;

  @override
  ConsumerState<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends ConsumerState<CustomNavBar> {
  int get page => widget.pageController.hasClients
      ? widget.pageController.page!.toInt()
      : 0;

  BorderRadius getBoxRadius(Orientation orientation) {
    final radius = Radius.circular(20);

    if (orientation == Orientation.portrait) {
      return BorderRadius.only(topLeft: radius, topRight: radius);
    }

    return BorderRadius.only(topLeft: radius, bottomLeft: radius);
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = ref.read(themeProvider.notifier);
    final isDarkMode = ref.watch(themeProvider);

    return OrientationBuilder(
      builder: (_, orientation) {
        final isPortrait = orientation == Orientation.portrait;

        return Container(
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
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      themeProv.switchTheme();

                      //setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isDarkMode
                            ? Icon(Icons.light_mode)
                            : Icon(Icons.dark_mode),
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFaf955e),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
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
