import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_content.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar.dart';

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
    return Flex(
      direction: MediaQuery.of(context).orientation == .portrait
          ? .vertical
          : .horizontal,
      children: [
        Expanded(child: MushafContent(pageController: pageController)),
        CustomNavBar(pageController: pageController),
      ],
    );
  }
}
