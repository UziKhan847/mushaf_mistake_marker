import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_content.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/custom_nav_bar.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  late final pageController = PageController();
  int rebuildNumber = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, orientation) {
        final isPortrait = orientation == Orientation.portrait;

        return Flex(
          direction: isPortrait ? Axis.vertical : Axis.horizontal,
          children: [
            Expanded(
              child: MushafContent(
                //isPortrait: isPortrait,
                pageController: pageController,
              ),
            ),
            CustomNavBar(pageController: pageController),
          ],
        );
      },
    );
  }
}
