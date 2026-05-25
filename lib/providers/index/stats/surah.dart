import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';

final surahsStatsNotifierProvider =
    NotifierProvider<SurahsStatsNotifier, List<Map<HighlightType, int>>>(
      SurahsStatsNotifier.new,
    );

class SurahsStatsNotifier extends Notifier<List<Map<HighlightType, int>>> {
  @override
  List<Map<HighlightType, int>> build() => List.generate(
    114,
    (index) => {.mistake: 0, .oldMistake: 0, .doubt: 0, .tajwid: 0},
  );

  void incrementStat(int index, HighlightType type) {
    if (state[index][type] == null || index < 0 || index >= state.length) {
      return;
    }
    state[index][type] = state[index][type]! + 1;
  }
}
