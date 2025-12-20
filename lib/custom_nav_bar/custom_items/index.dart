import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';

class IndexItem extends ConsumerWidget {
  const IndexItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavBarItem(
      iconLabel: 'Index',
      isSelected: false,
      onTap: () {},
      selectedAsset: MyFlutterApp.index,
      unselectedAsset: MyFlutterApp.index_outlined,
    );
  }
}
