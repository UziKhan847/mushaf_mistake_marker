import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';

class MushafItem extends ConsumerWidget {
  const MushafItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavBarItem(
      iconLabel: 'Mushaf',
      isSelected: false,
      onTap: () {},
      selectedAsset: MyFlutterApp.mushaf,
      unselectedAsset: MyFlutterApp.mushaf_outlined,
    );
  }
}
