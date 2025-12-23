import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/tiles/dual_page.dart';
import 'package:mushaf_mistake_marker/mushaf/tiles/single_page.dart';
import 'package:mushaf_mistake_marker/mushaf/page/page_changed_handler.dart';
import 'package:mushaf_mistake_marker/providers/pages_provider.dart';

class MushafPageBuilder extends ConsumerStatefulWidget {
  const MushafPageBuilder({
    super.key,
    required this.isDualPageMode,
    required this.controller,
    required this.constraints,
    this.isPortrait = false,
    this.reverse = true,
    this.initPage = 0,
  });

  final bool isDualPageMode;
  final PageController controller;
  final BoxConstraints constraints;
  final bool isPortrait;
  final bool reverse;
  final int initPage;

  @override
  ConsumerState<MushafPageBuilder> createState() => _MushafPagerState();
}

class _MushafPagerState extends ConsumerState<MushafPageBuilder> {
  late int prevPage;
  late final onPageHandler = PageChangedHandler(ref: ref);
  late final pages = ref.read(pagesProvider).value!;

  @override
  void initState() {
    super.initState();
    prevPage = widget.initPage;
  }

  @override
  Widget build(BuildContext context) {
    final int itemCount = widget.isDualPageMode ? 302 : 604;

    return PageView.builder(
      reverse: widget.reverse,
      controller: widget.controller,
      onPageChanged: (int index) async {
        prevPage = await onPageHandler.onPageChanged(
          prevPage,
          index,
          widget.isDualPageMode,
        );
      },
      itemCount: itemCount,
      itemBuilder: (_, index) {
        if (widget.isDualPageMode) {
          final int rightPage = index * 2;
          final int leftPage = rightPage + 1;

          return MushafDualPageTile(
            constraints: widget.constraints,
            pageData: [pages.pagesData[rightPage], pages.pagesData[leftPage]],
            dualPageIndex: [rightPage, leftPage],
          );
        } else {
          return MushafSinglePageTile(
            constraints: widget.constraints,
            pageData: pages.pagesData[index],
            isPortrait: widget.isPortrait,
            index: index,
          );
        }
      },
    );
  }
}
