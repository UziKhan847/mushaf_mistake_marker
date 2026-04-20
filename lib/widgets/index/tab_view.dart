import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/models/index/entry.dart';
import 'package:mushaf_mistake_marker/tiles/index.dart';

class IndexTabView extends StatelessWidget {
  const IndexTabView({super.key, required this.entries, this.onPageSelected});

  final List<IndexEntry> entries;
  final void Function(int)? onPageSelected;

  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: const .symmetric(vertical: 8),
    itemCount: entries.length,
    separatorBuilder: (_, _) =>
        const Divider(height: 1, indent: 72, endIndent: 16),
    itemBuilder: (context, i) => IndexTile(
      entry: entries[i],
      onNavigate: () => onPageSelected?.call(entries[i].page),
    ),
  );
}
