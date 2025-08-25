import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_dual_page_tile.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_loading.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_single_page_tile.dart';
import 'package:mushaf_mistake_marker/mushaf/on_page_changed_handler.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';
import 'package:mushaf_mistake_marker/providers/dual_page_provider.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_manager.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafPageView extends ConsumerStatefulWidget {
  const MushafPageView({
    super.key,
    required this.pages,
    required this.constraints,
    required this.isPortrait,
  });

  final Pages pages;
  final BoxConstraints constraints;
  final bool isPortrait;

  @override
  ConsumerState<MushafPageView> createState() => _MushafPageViewState();
}

class _MushafPageViewState extends ConsumerState<MushafPageView> {
  late final mushfaPgCrtl = ref.read(mushafPgCtrlProvider);
  late final initPage = mushfaPgCrtl.initialPage;
  late final prefs = ref.read(sharedPrefsProv);
  late int prevPage;
  late final onPgHandler = OnPageChangedHandler();
  late final List<Map<String, MarkType>> markedPgs = List.generate(
    604,
    (_) => {},
    growable: false,
  );

  @override
  void initState() {
    super.initState();
    preFetchPages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int getDualPageNumber(int pageIndex) {
    if (pageIndex.isEven) {
      return pageIndex ~/ 2;
    } else {
      return (pageIndex / 2).floor();
    }
  }

  Future<void> preFetchPages() async {
    final isDualPageMode = ref.read(pageModeProvider) && !widget.isPortrait;
    final offsets = [0, 1, -1, 2, -2, 3, 4];
    final List<Future> futures = [];

    final actualPage = isDualPageMode ? initPage * 2 : initPage;
    prevPage = initPage;

    for (final e in offsets) {
      if (actualPage + e >= 0 && actualPage + e <= 603) {
        futures.add(SpriteManager.fetchSpriteSheet(actualPage + e));
      }
    }

    await Future.wait(futures);
    setState(() {});
  }

  Future<void> _onPageChanged(int index, bool isDualPageMode) async {
    final isSwipe = (index - prevPage).abs() == 1;

    if (!isSwipe) {
      prevPage = index;
      return;
    }

    onPgHandler.savePageIndex(ref, index, isDualPageMode);

    final swipedLeft = index > prevPage;
    final actualPage = isDualPageMode ? index * 2 : index;

    List<int> fetchOffsets = onPgHandler.getFetchOffsets(swipedLeft);
    List<int> clearOffsets = onPgHandler.getClearOffsets(swipedLeft);

    await onPgHandler.fetchMissingImages(actualPage, fetchOffsets);
    setState(() {});
    onPgHandler.clearUnusedImages(actualPage, clearOffsets);

    prevPage = index;
  }

  @override
  Widget build(BuildContext context) {
    final isDualPage = ref.watch(pageModeProvider);
    final isDualPageMode = isDualPage && !widget.isPortrait;
    prefs.setBool('isDualPageMode', isDualPageMode);

    //pageViewIndex = isDualPageMode ? getDualPageNumber(initPage) : initPage;

    return isDualPageMode
        ? PageView.builder(
            reverse: true,
            onPageChanged: (int index) async {
              await _onPageChanged(index, isDualPageMode);
            },
            controller: mushfaPgCrtl,
            itemCount: 302,
            itemBuilder: (_, index) {
              final rightPage = index * 2;
              final leftPage = rightPage + 1;

              final pairMissing =
                  spriteSheets[rightPage].image == null ||
                  spriteSheets[leftPage].image == null;

              return pairMissing
                  ? MushafPageLoading()
                  : MushafDualPageTile(
                      constraints: widget.constraints,
                      markedPaths: [markedPgs[rightPage], markedPgs[leftPage]],
                      spriteSheet: [
                        spriteSheets[rightPage],
                        spriteSheets[leftPage],
                      ],
                      pageData: [
                        widget.pages.pageData[rightPage],
                        widget.pages.pageData[leftPage],
                      ],
                    );
            },
          )
        : PageView.builder(
            reverse: true,
            onPageChanged: (int index) async {
              await _onPageChanged(index, isDualPageMode);
            },
            controller: mushfaPgCrtl,
            itemCount: 604,
            itemBuilder: (_, index) {
              return spriteSheets[index].image == null
                  ? MushafPageLoading()
                  : MushafSinglePageTile(
                      constraints: widget.constraints,
                      markedPaths: markedPgs[index],
                      spriteSheet: spriteSheets[index],
                      pageData: widget.pages.pageData[index],
                      isPortrait: widget.isPortrait,
                    );
            },
          );
  }
}
