import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';

final statsProvider =
    NotifierProvider.family<
      StatsNotifier,
      List<Map<HighlightType, int>>,
      IndexTab
    >(StatsNotifier.new);

class StatsNotifier extends Notifier<List<Map<HighlightType, int>>> {
  StatsNotifier(this.indexTab);
  final IndexTab indexTab;

  @override
  List<Map<HighlightType, int>> build() => List.generate(
    indexTab.totalNum,
    (index) => {.mistake: 0, .oldMistake: 0, .doubt: 0, .tajwid: 0},
  );

  void incrementStat(int index, HighlightType type) {
    if (state[index][type] == null || index < 0 || index >= state.length) {
      return;
    }
    state[index][type] = state[index][type]! + 1;
  }
}
