import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/index/stats.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';

final indexStatsListsProvider = Provider<void>((ref) {
  final elements = ref.read(userMushafDataProvider)!.elementMarkData;

  final pageStats = ref.read(statsProvider(.pages)),
      surahsStats = ref.read(statsProvider(.surahs)),
      juzStats = ref.read(statsProvider(.juz)),
      hizbStats = ref.read(statsProvider(.hizb)),
      rubHStats = ref.read(statsProvider(.rubu)),
      manzilStats = ref.read(statsProvider(.manzil)),
      sajdahStats = ref.read(statsProvider(.sajdah));

  final elementRegEx = RegExp(r'(s\d+)(v\d+)(w\d+)_(rH\d+)(j\d+)');
  final specificRegEx = RegExp(r'([A-Za-z]+)(\d+)');

  for (final e in elements) {
    if (!e.key.contains('w')) continue;

    final match = elementRegEx.firstMatch(e.key);

    if (match == null) continue;

    final highlight = e.highlight;

    for (int i = 1; i <= match.groupCount; i++) {
      final str = specificRegEx.firstMatch(match[i]!);

      if (str == null) continue;

      final index = int.parse(str[2] as String) - 1;

      switch (str[1]) {
        case 's':
          surahsStats[index][highlight] = surahsStats[index][highlight]! + 1;

          late final int manzilNum;

          switch (index + 1) {
            case < 5:
              manzilNum = 0;
            case < 10:
              manzilNum = 1;
            case < 17:
              manzilNum = 2;
            case < 26:
              manzilNum = 3;
            case < 37:
              manzilNum = 4;
            case < 50:
              manzilNum = 5;
            default:
              manzilNum = 6;
          }

          manzilStats[manzilNum][highlight] =
              manzilStats[manzilNum][highlight]! + 1;
        case 'rH':
          rubHStats[index][highlight] = rubHStats[index][highlight]! + 1;

          final hizbIndex = (index) ~/ 4;
          hizbStats[hizbIndex][highlight] =
              hizbStats[hizbIndex][highlight]! + 1;
        case 'j':
          juzStats[index][highlight] = juzStats[index][highlight]! + 1;
        default:
          continue;
      }
    }
  }
});
