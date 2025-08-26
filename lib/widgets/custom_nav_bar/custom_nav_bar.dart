import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/page_mode_provider.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';
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
      ? widget.pageController.page!.round()
      : 0;
  late int targetPage;
  late int mushafPage;
  late final mushafPageCtrl = ref.read(mushafPgCtrlProvider);
  late final mushafPageCrtlProv = ref.read(mushafPgCtrlProvider.notifier);

  BorderRadius getBoxRadius(Orientation orientation) {
    final radius = Radius.circular(20);

    if (orientation == Orientation.portrait) {
      return BorderRadius.only(topLeft: radius, topRight: radius);
    }

    return BorderRadius.only(topLeft: radius, bottomLeft: radius);
  }

  @override
  Widget build(BuildContext context) {
    final (themeProv, isDarkMode) = (
      ref.read(themeProvider.notifier),
      ref.watch(themeProvider),
    );

    final (pageModeProv, isDualPage) = (
      ref.read(pageModeProvider.notifier),
      ref.watch(pageModeProvider),
    );

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
                Divider(color: Colors.black, height: 1, thickness: 1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      themeProv.switchTheme();
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      pageModeProv.setPageMode();
                      final newIsDualPage = !isDualPage;
                      mushafPageCrtlProv.preservePage(
                        newIsDualPage
                            ? PageLayout.dualPage
                            : PageLayout.singlePage,
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isDualPage ? Icon(Icons.pages) : Icon(Icons.lock_clock),
                        Text(
                          isDualPage ? 'DUAL ON' : 'DUAL OFF',
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
