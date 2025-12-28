import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/container.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar.dart';
import 'package:mushaf_mistake_marker/providers/orientation.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return ProviderScope(
      overrides: [orientationProvider.overrideWithValue(orientation)],
      child: Flex(
        direction: orientation == .portrait ? .vertical : .horizontal,
        children: [
          Expanded(
            child: MushafContainer(isPortrait: orientation == .portrait),
          ),
          CustomNavBar(),
        ],
      ),
    );
  }
}
