import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';
import 'package:mushaf_mistake_marker/providers/sprite_provider.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_manager.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class PageChangedHandler {
  PageChangedHandler({required this.ref});

  final WidgetRef ref;

  void savePageIndex(WidgetRef ref, int index, bool isDualPageMode) {
    final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider.notifier);

    final targetPage = isDualPageMode ? index * 2 : index;

    mushafPgCtrlProv.setPage(targetPage);
  }

  List<int> getFetchOffsets(bool swipedLeft) =>
      swipedLeft ? [0, 1, 2, 3, -1, -2] : [0, -1, -2, -3, 1, 2];

  List<int> getClearOffsets(bool swipedLeft) => swipedLeft ? [-3, -4] : [4, 5];

  bool isValidIndex(int index) => index >= 0 && index <= 603;

  Future<void> fetchMissingImages(int baseIndex, List<int> offsets) async {
    final spriteSheets = ref.read(spriteProvider);
    final spriteProv = ref.read(spriteProvider.notifier);
    final futures = <Future>[];

    for (final offset in offsets) {
      final index = baseIndex + offset;

      if (isValidIndex(index) && spriteSheets[index].image == null) {
        futures.add(spriteProv.fetchSpriteSheet(index));
      }
    }

    await Future.wait(futures);
  }

  void clearUnusedImages(int baseIndex, List<int> offsets) {
    final spriteSheets = ref.read(spriteProvider);
    final spriteProv = ref.read(spriteProvider.notifier);
    for (final offset in offsets) {
      final index = baseIndex + offset;

      if (isValidIndex(index) && spriteSheets[index].image != null) {
        spriteProv.clearImg(index);
      }
    }
  }

  Future<int> onPageChanged(
    int prevPage,
    int index,
    bool isDualPageMode,
  ) async {
    final isSwipe = (index - prevPage).abs() == 1;

    if (!isSwipe) {
      return index;
    }

    savePageIndex(ref, index, isDualPageMode);

    final swipedLeft = index > prevPage;
    final actualPage = isDualPageMode ? index * 2 : index;

    List<int> fetchOffsets = getFetchOffsets(swipedLeft);
    List<int> clearOffsets = getClearOffsets(swipedLeft);

    await fetchMissingImages(actualPage, fetchOffsets);
    clearUnusedImages(actualPage, clearOffsets);

    return index;
  }
}
