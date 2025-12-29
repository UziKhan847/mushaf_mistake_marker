import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_sheet.dart';

class PageChangedHandler {
  PageChangedHandler({required this.ref})
    : spriteProv = ref.read(spriteProvider.notifier),
      spriteSheets = ref.read(spriteProvider);

  final WidgetRef ref;
  final SpriteNotifier spriteProv;
  final List<SpriteSheet> spriteSheets;

  void savePageIndex(int index, bool dualPageMode) {
    final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider.notifier);

    final targetPage = dualPageMode ? index * 2 : index;

    mushafPgCtrlProv.setUserPage(targetPage);
  }

  List<int> get getJumpToOffsets => [0, -1, -2, -3, 1, 2, 3];

  List<int> getFetchOffsets(bool swipedLeft) =>
      swipedLeft ? [0, 1, 2, 3, -1, -2] : [0, -1, -2, -3, 1, 2];

  List<int> getClearOffsets(bool swipedLeft) => swipedLeft ? [-3, -4] : [4, 5];

  bool isValidIndex(int index) => index >= 0 && index <= 603;

  Future<void> fetchMissingImages(int baseIndex, List<int> offsets) async {
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
    for (final offset in offsets) {
      final index = baseIndex + offset;

      if (isValidIndex(index) && spriteSheets[index].image != null) {
        spriteProv.clearImg(index);
      }
    }
  }

  void clearUnusedSprite(int baseIndex, List<int> offsets) {
    for (final offset in offsets) {
      final index = baseIndex + offset;

      if (isValidIndex(index) && spriteSheets[index].image != null) {
        spriteProv.clearSprite(index);
      }
    }
  }

  Future<int> onPageChanged(
    int prevPage,
    int index,
    bool dualPageMode,
  ) async {
    final isSwipe = (index - prevPage).abs() == 1;

    if (!isSwipe) {
      return index;
    }

    savePageIndex(index, dualPageMode);

    final swipedLeft = index > prevPage;
    final actualPage = dualPageMode ? index * 2 : index;

    List<int> fetchOffsets = getFetchOffsets(swipedLeft);
    List<int> clearOffsets = getClearOffsets(swipedLeft);

    await fetchMissingImages(actualPage, fetchOffsets);
    clearUnusedImages(actualPage, clearOffsets);

    return index;
  }

  void onJumpToPage(int index) async {
    //final prefs = ref.read(sharedPrefsProv);
    final mshfPgCtrlProv = ref.read(mushafPgCtrlProvider.notifier);

    mshfPgCtrlProv.setUserPage(index);

    spriteProv.clearAll();

    //late final int actualPage;

    //actualPage = dualPageMode ? index * 2 : index;

    //mshfPgCtrlProv.setPage(index);

    //spriteProv.clearAll();
    //await fetchMissingImages(actualPage, getJumpToOffsets);
  }
}
