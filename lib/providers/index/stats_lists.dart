import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';

final indexStatsListsProvider = Provider<void>((ref) {
  final elements = ref.read(userMushafDataProvider)!.elementMarkData;

  final List<Map<HighlightType, int>> surahsStats = List.generate(
    114,
    (index) => {.mistake: 0, .oldMistake: 0, .doubt: 0, .tajwid: 0},
  );

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

      switch (str[1]) {
        case 's':
          final n = int.parse(str[2] as String);
          surahsStats[n - 1][highlight] = surahsStats[n - 1][highlight]! + 1;
        case 'v':
          final n = int.parse(str[2] as String);

        case 'w':
          final n = int.parse(str[2] as String);

        case 'rH':
          final n = int.parse(str[2] as String);

        case 'j':
          final n = int.parse(str[2] as String);

        default:
          throw Exception('No match');
      }
    }
  }
});
