import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/content.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: MediaQuery.of(context).orientation == .portrait
          ? .vertical
          : .horizontal,
      children: [
        Expanded(child: MushafContent()),
        CustomNavBar(),
      ],
    );
  }
}
