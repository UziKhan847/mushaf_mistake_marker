// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mushaf_mistake_marker/helpers/index.dart';
// import 'package:mushaf_mistake_marker/models/index/entry.dart';
// import 'package:mushaf_mistake_marker/providers/pages_provider.dart';
// import 'package:mushaf_mistake_marker/surah/surah_names_data.dart';

// class IndexLists {
//   const IndexLists({
//     required this.pages,
//     required this.surahs,
//     required this.juz,
//     required this.hizb,
//     required this.rubu,
//     required this.sajdah,
//   });

//   final List<IndexEntry> pages;
//   final List<IndexEntry> surahs;
//   final List<IndexEntry> juz;
//   final List<IndexEntry> hizb;
//   final List<IndexEntry> rubu;
//   final List<IndexEntry> sajdah;
// }

// final indexListsProvider =
//     AsyncNotifierProvider<IndexListsNotifier, IndexLists>(
//       IndexListsNotifier.new,
//     );

// class IndexListsNotifier extends AsyncNotifier<IndexLists> {
//   @override
//   Future<IndexLists> build() async {
//     final pagesData = (await ref.watch(pagesProvider.future)).pagesData;

//     final Map<int, int> surahVerseCount = {
//       for (final s in surahsData) s['num'] as int: s['totalVrs'] as int,
//     };

//     final Map<int, int> surahFirstPage = {};
//     final Map<int, int> juzFirstPage = {};
//     final Map<int, int> hizbFirstPage = {};
//     final Map<int, int> rubuFirstPage = {};
//     final Map<int, (int, int)> juzStartVerse = {};
//     final Map<int, (int, int)> hizbStartVerse = {};
//     final Map<int, (int, int)> rubuStartVerse = {};

//     for (final p in pagesData) {
//       for (final sr in p.srNum) {
//         surahFirstPage.putIfAbsent(sr, () => p.pNum);
//       }
//       for (final jz in p.jzNum) {
//         if (!juzFirstPage.containsKey(jz)) {
//           juzFirstPage[jz] = p.pNum;
//           juzStartVerse[jz] = firstVerseOnPage(p);
//         }
//       }
//       for (final hz in p.hzNum) {
//         if (!hizbFirstPage.containsKey(hz)) {
//           hizbFirstPage[hz] = p.pNum;
//           hizbStartVerse[hz] = firstVerseOnPage(p);
//         }
//       }
//       for (final rh in p.rHzbNum) {
//         if (!rubuFirstPage.containsKey(rh)) {
//           rubuFirstPage[rh] = p.pNum;
//           rubuStartVerse[rh] = firstVerseOnPage(p);
//         }
//       }
//     }

//     final pageEntries = pagesData
//         .map(
//           (p) => IndexEntry(
//             title: 'Page ${p.pNum}',
//             subtitle: pageSubtitle(p),
//             page: p.pNum,
//           ),
//         )
//         .toList();

//     final List<IndexEntry> surahEntries = [];
//     final List<IndexEntry> juzEntries = [];
//     final List<IndexEntry> hizbEntries = [];
//     final List<IndexEntry> rubuEntries = [];

//     for (int i = 1; i <= 240; i++) {
//       if (i <= 114) {
//         surahEntries.add(
//           IndexEntry(
//             title: surahName(i),
//             subtitle: '${surahVerseCount[i]} verses',
//             page: surahFirstPage[i]!,
//           ),
//         );
//       }
//       if (i <= 30) {
//         final (sr, vr) = juzStartVerse[i]!;
//         juzEntries.add(
//           IndexEntry(
//             title: 'Juzʾ $i',
//             subtitle: 'Starts at ${surahName(sr)} $sr:$vr',
//             page: juzFirstPage[i]!,
//           ),
//         );
//       }
//       if (i <= 60) {
//         final (sr, vr) = hizbStartVerse[i]!;
//         hizbEntries.add(
//           IndexEntry(
//             title: 'Hizb $i',
//             subtitle: 'Starts at ${surahName(sr)} $sr:$vr',
//             page: hizbFirstPage[i]!,
//           ),
//         );
//       }
//       final (sr, vr) = rubuStartVerse[i]!;
//       rubuEntries.add(
//         IndexEntry(
//           title: 'Rubʿ $i',
//           subtitle: 'Starts at ${surahName(sr)} $sr:$vr',
//           page: rubuFirstPage[i]!,
//         ),
//       );
//     }

//     final sajdahEntries = pagesData.where((p) => p.sjdNum != null).map((p) {
//       final (sr, vr) = sajdahLocations[p.sjdNum! - 1];
//       return IndexEntry(
//         title: 'Sajdah ${p.sjdNum}',
//         subtitle: '${surahName(sr)} $sr:$vr',
//         page: p.pNum,
//       );
//     }).toList();

//     print('Number of Element: ${juzEntries.length}');
//     print('Page: ${juzEntries[3].page}');
//     print(juzEntries[3].subtitle);
//     print('Name: ${juzEntries[3].title}');

//     return IndexLists(
//       pages: pageEntries,
//       surahs: surahEntries,
//       juz: juzEntries,
//       hizb: hizbEntries,
//       rubu: rubuEntries,
//       sajdah: sajdahEntries,
//     );
//   }
// }
