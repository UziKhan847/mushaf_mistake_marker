import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';

final statsProvider = NotifierProvider.family
    .autoDispose<StatsNotifier, List<Map<HighlightType, int>>, IndexTab>(
      StatsNotifier.new,
    );

class StatsNotifier extends Notifier<List<Map<HighlightType, int>>> {
  StatsNotifier(this.indexTab);
  final IndexTab indexTab;

  @override
  List<Map<HighlightType, int>> build() => List.generate(
    indexTab.totalNum,
    (index) => {.mistake: 0, .oldMistake: 0, .doubt: 0, .tajwid: 0},
  );

  void incrementStat(int index, HighlightType type) {
    if (index < 0 || index >= state.length) return;
    final bucket = state[index];
    if (!bucket.containsKey(type)) return;
    bucket[type] = bucket[type]! + 1;
  }
}
