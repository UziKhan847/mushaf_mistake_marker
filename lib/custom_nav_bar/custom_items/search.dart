import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/settings.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/user.dart';

class SearchItem extends ConsumerWidget {
  const SearchItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    return NavBarItem(
      iconLabel: 'Search',
      isSelected: false,
      onTap: () {},
      child: Icon(MyFlutterApp.search, color: cs.onSurfaceVariant),
    );
  }
}
