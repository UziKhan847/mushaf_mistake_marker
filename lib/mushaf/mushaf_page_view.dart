import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_dual_page_tile.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_loading.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_single_page_tile.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';
import 'package:mushaf_mistake_marker/providers/dual_page_provider.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';
import 'package:mushaf_mistake_marker/sprite/sprite.dart';
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
  bool preFecthedComplete = false;

  late final mushfaPgCrtl = ref.read(mushafPgCtrlProvider);
  late final initPage = mushfaPgCrtl.initialPage;
  late int pageViewIndex;
  late int prevPage = pageViewIndex;
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

  void preFetchPages() async {
    final offsets = [0, 1, -1, 2, -2, 3, 4];
    final List<Future> futures = [];

    for (final e in offsets) {
      if (initPage + e >= 0 && initPage + e <= 603) {
        futures.add(SpriteManager.fetchSpriteSheet(initPage + e));
      }
    }

    await Future.wait(futures);
    setState(() {});
  }

  Future<void> _onPageChanged(int index, bool isDualPageMode) async {
    final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider.notifier);
    mushafPgCtrlProv.setPage(index, isDualPageMode);
    final swipedLeft = index > prevPage;

    final actualPage = isDualPageMode ? index * 2 : index;
    List<int> fetchOffsets = [];
    List<int> clearOffsets = [];
    final List<Future> futures = [];

    if (swipedLeft) {
      fetchOffsets = [1, 2, 3, -1, -2];
      clearOffsets = [-3, -4];
    } else {
      fetchOffsets = [-1, -2, -3, 1, 2];
      clearOffsets = [3, 4];
    }

    for (final e in fetchOffsets) {
      final _index = actualPage + e;

      if (_index >= 0 && _index <= 603) {
        if (spriteSheets[_index].image == null) {
          futures.add(SpriteManager.fetchSpriteSheet(_index));
        }
      }
    }

    await Future.wait(futures);
    setState(() {});

    for (final e in clearOffsets) {
      final _index = actualPage + e;

      if (_index >= 0 && _index <= 603) {
        if (spriteSheets[_index].image != null) {
          SpriteManager.clearImg(_index);
        }
      }
    }

    prevPage = index;
  }

  @override
  Widget build(BuildContext context) {
    final isDualPage = ref.watch(pageModeProvider);
    final isDualPageMode = isDualPage && !widget.isPortrait;

    pageViewIndex = isDualPageMode ? getDualPageNumber(initPage) : initPage;

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
            itemCount: isDualPageMode ? 302 : 604,
            itemBuilder: (_, index) {
              if (isDualPageMode) {
                final i1 = index * 2;
                final i2 = i1 + 1;

                final pairMissing =
                    spriteSheets[i1].image == null ||
                    spriteSheets[i2].image == null;

                return pairMissing
                    ? MushafPageLoading()
                    : MushafDualPageTile(
                        constraints: widget.constraints,
                        markedPaths: [markedPgs[i1], markedPgs[i2]],
                        spriteSheet: [spriteSheets[i1], spriteSheets[i2]],
                        pageData: [
                          widget.pages.pageData[i1],
                          widget.pages.pageData[i2],
                        ],
                      );
              } else {
                return spriteSheets[index].image == null
                    ? MushafPageLoading()
                    : MushafSinglePageTile(
                        constraints: widget.constraints,
                        markedPaths: markedPgs[index],
                        spriteSheet: spriteSheets[index],
                        pageData: widget.pages.pageData[index],
                        isPortrait: widget.isPortrait,
                      );
              }
            },
          );

    // return PageView.builder(
    //   reverse: true,
    //   onPageChanged: (int index) async {
    //     await _onPageChanged(index, isDualPageMode);
    //   },
    //   controller: mushfaPgCrtl,
    //   itemCount: isDualPageMode ? 302 : 604,
    //   itemBuilder: (_, index) {
    //     if (isDualPageMode) {
    //       final i1 = index * 2;
    //       final i2 = i1 + 1;

    //       final pairMissing =
    //           spriteSheets[i1].image == null || spriteSheets[i2].image == null;

    //       return pairMissing
    //           ? MushafPageLoading()
    //           : MushafDualPageTile(
    //               constraints: widget.constraints,
    //               markedPaths: [markedPgs[i1], markedPgs[i2]],
    //               spriteSheet: [spriteSheets[i1], spriteSheets[i2]],
    //               pageData: [
    //                 widget.pages.pageData[i1],
    //                 widget.pages.pageData[i2],
    //               ],
    //             );
    //     } else {
    //       return spriteSheets[index].image == null
    //           ? MushafPageLoading()
    //           : MushafSinglePageTile(
    //               constraints: widget.constraints,
    //               markedPaths: markedPgs[index],
    //               spriteSheet: spriteSheets[index],
    //               pageData: widget.pages.pageData[index],
    //               isPortrait: widget.isPortrait,
    //             );
    //     }
    //   },
    // );
  }
}
