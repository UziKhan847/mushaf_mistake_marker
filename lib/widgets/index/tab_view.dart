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
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: tab.totalNum,
      separatorBuilder: (_, _) =>
          const Divider(height: 1, indent: 72, endIndent: 16),
      itemBuilder: (context, index) => IndexTile(
        tab: tab,
        index: index,
        onNavigate: () {}, // TODO: your jump logic
      ),
    );
  }
}
