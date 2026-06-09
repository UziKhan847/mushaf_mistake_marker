import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/providers/pages_provider.dart';

final pagesNumberProvider =
    AsyncNotifierProvider<PagesNumberNotifier, Map<IndexTab, List<int?>>>(
      PagesNumberNotifier.new,
    );

class PagesNumberNotifier extends AsyncNotifier<Map<IndexTab, List<int?>>> {
  @override
  Future<Map<IndexTab, List<int?>>> build() async {
    final pages = await ref.watch(pagesProvider.future);

    final index = {
      for (final tab in IndexTab.values)
        if (tab != .pages)
          tab: List<int?>.filled(tab.totalNum, null, growable: false),
    };

    for (final page in pages.pagesData) {
      final pNum = page.pNum;
      getFirstPages(index[IndexTab.manzil]!, pNum, page.mnzlNum);
      getFirstPages(index[IndexTab.juz]!, pNum, page.jzNum);
      getFirstPages(index[IndexTab.rubu]!, pNum, page.rHzbNum);
      getFirstPages(
        index[IndexTab.hizb]!,
        pNum,
        page.rHzbNum.map((e) => (e / 4).ceil()),
      );
      getFirstPages(index[IndexTab.surahs]!, pNum, page.srNum);
      if (page.sjdNum != null) {
        getFirstPages(index[IndexTab.sajdah]!, pNum, <int>{page.sjdNum!});
      }
    }

    return index;
  }
}

void getFirstPages(List<int?> target, int pNum, Iterable<int> keys) {
  for (final k in keys) {
    if (target[k - 1] != null) continue;
    target[k - 1] = pNum;
  }
}
