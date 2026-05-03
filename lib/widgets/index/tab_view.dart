import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/models/index/entry.dart';
import 'package:mushaf_mistake_marker/providers/index/lists.dart';
import 'package:mushaf_mistake_marker/tiles/index.dart';
import 'package:mushaf_mistake_marker/tiles/index_sajdah.dart';

class IndexTabView extends ConsumerWidget {
  const IndexTabView({super.key, required this.tab});

  final IndexTab tab;

  List<IndexEntry> getEntries(IndexTab tab, WidgetRef ref) => switch (tab) {
    .surahs => ref.read(indexListsProvider).value!.surahs,
    .juz => ref.read(indexListsProvider).value!.juz,
    .hizb => ref.read(indexListsProvider).value!.hizb,
    .rubu => ref.read(indexListsProvider).value!.rubu,
    .sajdah => ref.read(indexListsProvider).value!.sajdah,
    .manzil => ref.read(indexListsProvider).value!.manzil,
    _ => ref.read(indexListsProvider).value!.pages,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = getEntries(tab, ref);

    return ListView.separated(
      padding: const .symmetric(vertical: 8),
      itemCount: entries.length,
      separatorBuilder: (_, _) =>
          const Divider(height: 1, indent: 72, endIndent: 16),
      itemBuilder: (context, i) => tab == .sajdah
          ? IndexSajdahTile(
              entry: entries[i],
              onNavigate: () {},
              tab: tab,
              index: i,
            )
          : IndexTile(entry: entries[i], onNavigate: () {}, tab: tab, index: i),
    );
  }
}
