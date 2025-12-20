import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';

final markedSurahsProvider =
    NotifierProvider<MarkedSurahsProvider, List<Map<String, MarkType>>>(
      MarkedSurahsProvider.new,
    );

class MarkedSurahsProvider extends Notifier<List<Map<String, MarkType>>> {
  @override
  build() {
    return List.generate(114, (index) => {});
  }

  void setMark(int markedSurah, String id, MarkType markType) {
    final newList = [...state];
    final Map<String, MarkType> newMap = Map.from(newList[markedSurah]);

    newMap[id] = markType;

    newList[markedSurah] = newMap;

    state = newList;
  }

  void removeMark(int markedSurah, String id) {
    final newList = [...state];
    final Map<String, MarkType> newMap = Map.from(newList[markedSurah]);

    newMap.remove(id);
    newList[markedSurah] = newMap;

    state = newList;
  }

  MarkType? getMarkType(int markedSurah, String id) =>
      switch (state[markedSurah][id]) {
        .doubt => .mistake,
        .mistake => .oldMistake,
        .oldMistake => .tajwid,
        .tajwid => null,
        _ => .doubt,
      };

  
}

