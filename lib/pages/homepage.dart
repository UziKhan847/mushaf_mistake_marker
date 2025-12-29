import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/page_mode_listener.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Flex(
      direction: orientation == .portrait ? .vertical : .horizontal,
      children: [
        Expanded(child: MushafPageModeListener()),
        CustomNavBar(),
      ],
    );
  }
}
