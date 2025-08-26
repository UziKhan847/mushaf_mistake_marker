import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';
import 'package:mushaf_mistake_marker/widgets/custom_flex.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_nav_bar.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key, required this.pages});

  final Pages pages;

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  late final pageController = PageController();
  late final mushafPgCrtl = ref.read(mushafPgCtrlProvider);
  late final mushafPgCrtlProv = ref.read(mushafPgCtrlProvider.notifier);
  late final prefs = ref.read(sharedPrefsProv);
  bool? oldIsPortrait;
  bool firstLaunch = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void perservePageOnOrientChange(bool isPortrait, bool isDualPage) {
    if (firstLaunch) {
      oldIsPortrait = isPortrait;
      firstLaunch = false;
      return;
    }

    if (oldIsPortrait != isPortrait && isDualPage) {
      mushafPgCrtlProv.preservePage(isPortrait ? PageLayout.singlePage : PageLayout.dualPage);
      oldIsPortrait = isPortrait;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomFlex(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (_, constraints) {
              final isPortrait = constraints.maxHeight >= constraints.maxWidth;
              final isDualPage = prefs.getBool('savedPageMode') ?? false;

              perservePageOnOrientChange(isPortrait, isDualPage);

              return PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  MushafPageView(
                    pages: widget.pages,
                    constraints: constraints,
                    isPortrait: isPortrait,
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.redAccent,
                        width: double.infinity,
                        height: 500,
                      ),
                    ],
                  ),
                  Container(color: Colors.blueAccent),
                  Container(color: Colors.amberAccent),
                ],
              );
            },
          ),
        ),
        CustomNavBar(pageController: pageController),
      ],
    );
  }
}
