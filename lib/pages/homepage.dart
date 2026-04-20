import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/pre_fetcher.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.orientationOf(context) == .portrait;

    return Flex(
      direction: isPortrait ? .vertical : .horizontal,
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (_, constraints) {
              return MushafPagePreFetcher(constraints: constraints);
            },
          ),
        ),
        CustomNavBar(),
      ],
    );
  }
}
