import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/settings.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/user.dart';

class IndexItem extends ConsumerWidget {
  const IndexItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavBarItem(
      iconLabel: 'Index',
      isSelected: false,
      onTap: () {
        final userBox = ref.read(userBoxProvider);
        final mshfDataBox = ref.read(mushafDataBoxProvider);
        final settingsBox = ref.read(settingsBoxProvider);

        mshfDataBox.removeAll();
        settingsBox.removeAll();
        userBox.removeAll();
      },
      selectedAsset: MyFlutterApp.index,
      unselectedAsset: MyFlutterApp.index_outlined,
    );
  }
}
