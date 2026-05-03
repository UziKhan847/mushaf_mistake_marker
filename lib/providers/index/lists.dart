import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/helpers/index.dart';
import 'package:mushaf_mistake_marker/models/index/entry.dart';
import 'package:mushaf_mistake_marker/models/index/lists.dart';
import 'package:mushaf_mistake_marker/providers/index/ids_maps.dart';
import 'package:mushaf_mistake_marker/providers/pages_provider.dart';
import 'package:mushaf_mistake_marker/surah/surah_names_data.dart';

final indexListsProvider =
    AsyncNotifierProvider<IndexListsNotifier, IndexLists>(
      IndexListsNotifier.new,
    );

class IndexListsNotifier extends AsyncNotifier<IndexLists> {
  @override
  Future<IndexLists> build() async {
    final pagesData = (await ref.watch(pagesProvider.future)).pagesData;
    await ref.watch(indexIdsMapsProvider.future);

    final Map<int, int> surahVerseCount = {
      for (final s in surahsData) s['num'] as int: s['totalVrs'] as int,
    };

    final Map<int, int> surahFirstPage = {},
        juzFirstPage = {},
        hizbFirstPage = {},
        rubuFirstPage = {},
        manzilFirstPage = {};
    final Map<int, (int, int)> juzStartVerse = {},
        hizbStartVerse = {},
        rubuStartVerse = {},
        manzilStartVerse = {};
    final List<IndexEntry> surahEntries = [],
        juzEntries = [],
        hizbEntries = [],
        rubuEntries = [],
        manzilEntries = [];

    for (final p in pagesData) {
      for (final sr in p.srNum) {
        surahFirstPage.putIfAbsent(sr, () => p.pNum);
      }
      for (final jz in p.jzNum) {
        if (!juzFirstPage.containsKey(jz)) {
          juzFirstPage[jz] = p.pNum;
          juzStartVerse[jz] = firstVerseOnPage(p);
        }
      }
      for (final hz in p.hzNum) {
        if (!hizbFirstPage.containsKey(hz)) {
          hizbFirstPage[hz] = p.pNum;
          hizbStartVerse[hz] = firstVerseOnPage(p);
        }
      }
      for (final rh in p.rHzbNum) {
        if (!rubuFirstPage.containsKey(rh)) {
          rubuFirstPage[rh] = p.pNum;
          rubuStartVerse[rh] = firstVerseOnPage(p);
        }
      }
      for (final mn in p.mnzlNum) {
        if (!manzilFirstPage.containsKey(mn)) {
          manzilFirstPage[mn] = p.pNum;
          manzilStartVerse[mn] = firstVerseOnPage(p);
        }
      }
    }

    final pageEntries = pagesData
        .map(
          (p) => IndexEntry(
            title: 'Page ${p.pNum}',
            subtitle: pageSubtitle(p),
            page: p.pNum,
          ),
        )
        .toList();

    for (int i = 1; i <= 240; i++) {
      if (i <= 114) {
        surahEntries.add(
          IndexEntry(
            title: '$i. ${surahName(i)}',
            subtitle: '${surahVerseCount[i]} verses',
            page: surahFirstPage[i]!,
          ),
        );
      }
      if (i <= 7) {
        final (sr, vr) = manzilStartVerse[i]!;
        manzilEntries.add(
          IndexEntry(
            title: 'Manzil $i',
            subtitle: 'Starts at ${surahName(sr)} $sr:$vr',
            page: manzilFirstPage[i]!,
          ),
        );
      }
      if (i <= 30) {
        final (sr, vr) = juzStartVerse[i]!;
        juzEntries.add(
          IndexEntry(
            title: 'Juzʾ $i',
            subtitle: 'Starts at ${surahName(sr)} $sr:$vr',
            page: juzFirstPage[i]!,
          ),
        );
      }
      if (i <= 60) {
        final (sr, vr) = hizbStartVerse[i]!;
        hizbEntries.add(
          IndexEntry(
            title: 'Hizb $i',
            subtitle: 'Starts at ${surahName(sr)} $sr:$vr',
            page: hizbFirstPage[i]!,
          ),
        );
      }
      final (sr, vr) = rubuStartVerse[i]!;
      rubuEntries.add(
        IndexEntry(
          title: 'Rubʿ $i',
          subtitle: '${rubuQuarterIcon(i)} Starts at ${surahName(sr)} $sr:$vr',
          page: rubuFirstPage[i]!,
        ),
      );
    }

    final sajdahEntries = pagesData.where((p) => p.sjdNum != null).map((p) {
      final (sr, vr) = sajdahLocations[p.sjdNum! - 1];
      return IndexEntry(
        title: 'Sajdah ${p.sjdNum}',
        subtitle: '${surahName(sr)} $sr:$vr',
        page: p.pNum,
      );
    }).toList();

    return IndexLists(
      pages: pageEntries,
      surahs: surahEntries,
      juz: juzEntries,
      hizb: hizbEntries,
      rubu: rubuEntries,
      manzil: manzilEntries,
      sajdah: sajdahEntries,
    );
  }
}
