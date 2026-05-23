import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/tiles/index.dart';

class IndexTabView extends ConsumerWidget {
  const IndexTabView({super.key, required this.tab});

  final IndexTab tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      padding: const .symmetric(vertical: 8),
      itemCount: tab.indexList.length,
      separatorBuilder: (_, _) =>
          const Divider(height: 1, indent: 72, endIndent: 16),
      itemBuilder: (context, i) => IndexTile(
        entry: tab.indexList[i],
        onNavigate: () {},
        tab: tab,
        index: i,
      ),
    );
  }
}
