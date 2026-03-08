import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';

final markedSurahsProvider =
    NotifierProvider<MarkedSurahsProvider, List<Map<String, HighlightType>>>(
      MarkedSurahsProvider.new,
    );

class MarkedSurahsProvider extends Notifier<List<Map<String, HighlightType>>> {
  @override
  build() {
    return List.generate(114, (index) => {});
  }

  void setMark(int markedSurah, String id, HighlightType highlight) {
    final newList = [...state];
    final Map<String, HighlightType> newMap = Map.from(newList[markedSurah]);

    newMap[id] = highlight;

    newList[markedSurah] = newMap;

    state = newList;
  }

  void removeMark(int markedSurah, String id) {
    final newList = [...state];
    final Map<String, HighlightType> newMap = Map.from(newList[markedSurah]);

    newMap.remove(id);
    newList[markedSurah] = newMap;

    state = newList;
  }

  HighlightType? getHighlightType(int markedSurah, String id) =>
      switch (state[markedSurah][id]) {
        .doubt => .mistake,
        .mistake => .oldMistake,
        .oldMistake => .tajwid,
        .tajwid => null,
        _ => .doubt,
      };
}
