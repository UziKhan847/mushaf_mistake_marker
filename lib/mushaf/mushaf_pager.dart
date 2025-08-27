import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_dual_page_tile.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_loading.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_single_page_tile.dart';
import 'package:mushaf_mistake_marker/mushaf/page_changed_handler.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';
import 'package:mushaf_mistake_marker/providers/sprite_provider.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafPager extends ConsumerStatefulWidget {
  const MushafPager({
    super.key,
    required this.isDualPageMode,
    required this.controller,
    required this.markedPgs,
    required this.pages,
    required this.constraints,
    required this.ref,
    this.isPortrait = false,
    this.reverse = true,
    this.initialPrevPage = 0,
  });

  final bool isDualPageMode;
  final PageController controller;
  final List<Map<String, MarkType>> markedPgs;
  final Pages pages;
  final BoxConstraints constraints;
  final WidgetRef ref;
  final bool isPortrait;
  final bool reverse;
  final int initialPrevPage;

  @override
  ConsumerState<MushafPager> createState() => _MushafPagerState();
}

class _MushafPagerState extends ConsumerState<MushafPager> {
  late int prevPage;
  late final onPageHandler = PageChangedHandler(ref: ref);

  @override
  void initState() {
    super.initState();
    prevPage = widget.initialPrevPage;
  }

  @override
  Widget build(BuildContext context) {
    final int itemCount = widget.isDualPageMode ? 302 : 604;
    final spriteSheets = ref.watch(spriteProvider);

    return PageView.builder(
      reverse: widget.reverse,
      controller: widget.controller,
      onPageChanged: (int index) async {
        prevPage = await onPageHandler.onPageChanged(
          prevPage,
          index,
          widget.isDualPageMode,
        );
       // setState(() {});
      },
      itemCount: itemCount,
      itemBuilder: (_, index) {
        if (widget.isDualPageMode) {
          final int rightPage = index * 2;
          final int leftPage = rightPage + 1;

          final bool pairMissing =
              spriteSheets[rightPage].image == null ||
              spriteSheets[leftPage].image == null;

          return pairMissing
              ? MushafPageLoading()
              : MushafDualPageTile(
                  constraints: widget.constraints,
                  markedPaths: [
                    widget.markedPgs[rightPage],
                    widget.markedPgs[leftPage],
                  ],
                  spriteSheet: [
                    spriteSheets[rightPage],
                    spriteSheets[leftPage],
                  ],
                  pageData: [
                    widget.pages.pageData[rightPage],
                    widget.pages.pageData[leftPage],
                  ],
                );
        } else {
          final int pageIndex = index;
          final bool missing = spriteSheets[pageIndex].image == null;

          return missing
              ? MushafPageLoading()
              : MushafSinglePageTile(
                  constraints: widget.constraints,
                  markedPaths: widget.markedPgs[pageIndex],
                  spriteSheet: spriteSheets[pageIndex],
                  pageData: widget.pages.pageData[pageIndex],
                  isPortrait: widget.isPortrait,
                );
        }
      },
    );
  }
}
