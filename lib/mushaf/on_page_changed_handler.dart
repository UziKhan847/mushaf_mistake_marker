// class OnPageChangedHandler {


//   static void savePageIndex(int index, bool isDualPageMode) {
//     final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider.notifier);

//     if (isDualPageMode) {
//       targetPage = index * 2;
//     } else {
//       targetPage = (index / 2).floor();
//     }
//     mushafPgCtrlProv.setPage(targetPage);
//   }

//   List<int> getFetchOffsets(bool swipedLeft) =>
//       swipedLeft ? [1, 2, 3, -1, -2] : [-1, -2, -3, 1, 2];

//   List<int> getClearOffsets(bool swipedLeft) => swipedLeft ? [-3, -4] : [4, 5];

//   bool isValidIndex(int index) => index >= 0 && index <= 603;

//   Future<void> fetchMissingImages(int baseIndex, List<int> offsets) async {
//     final futures = <Future>[];

//     for (final offset in offsets) {
//       final index = baseIndex + offset;

//       if (isValidIndex(index) && spriteSheets[index].image == null) {
//         futures.add(SpriteManager.fetchSpriteSheet(index));
//       }
//     }

//     await Future.wait(futures);
//   }

//   void clearUnusedImages(int baseIndex, List<int> offsets) {
//     for (final offset in offsets) {
//       final index = baseIndex + offset;

//       if (isValidIndex(index) && spriteSheets[index].image != null) {
//         SpriteManager.clearImg(index);
//       }
//     }
//   }

//   Future<void> _onPageChanged(int index, bool isDualPageMode) async {
//     final isSwipe = (index - prevPage).abs() == 1;

//     if (!isSwipe) {
//       prevPage = index;
//       return;
//     }

//     savePageIndex(index, isDualPageMode);

//     final swipedLeft = index > prevPage;
//     final actualPage = isDualPageMode ? index * 2 : index;

//     List<int> fetchOffsets = getFetchOffsets(swipedLeft);
//     List<int> clearOffsets = getClearOffsets(swipedLeft);

//     await fetchMissingImages(actualPage, fetchOffsets);
//     setState(() {});
//     clearUnusedImages(actualPage, clearOffsets);

//     prevPage = index;
//   }


// }