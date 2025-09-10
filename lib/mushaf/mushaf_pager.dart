import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_dual_page_tile.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_single_page_tile.dart';
import 'package:mushaf_mistake_marker/mushaf/page_changed_handler.dart';
import 'package:mushaf_mistake_marker/providers/pages_provider.dart';

class MushafPager extends ConsumerStatefulWidget {
  const MushafPager({
    super.key,
    required this.isDualPageMode,
    required this.controller,
    required this.constraints,
    required this.ref,
    this.isPortrait = false,
    this.reverse = true,
    this.initPage = 0,
  });

  final bool isDualPageMode;
  final PageController controller;
  final BoxConstraints constraints;
  final WidgetRef ref;
  final bool isPortrait;
  final bool reverse;
  final int initPage;

  @override
  ConsumerState<MushafPager> createState() => _MushafPagerState();
}

class _MushafPagerState extends ConsumerState<MushafPager> {
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
        // setState(() {});
      },
      itemCount: itemCount,
      itemBuilder: (_, index) {
        if (widget.isDualPageMode) {
          final int rightPage = index * 2;
          final int leftPage = rightPage + 1;

          return MushafDualPageTile(
            constraints: widget.constraints,
            pageData: [pages.pageData[rightPage], pages.pageData[leftPage]],
            dualPageIndex: [rightPage, leftPage],
          );
        } else {
          return MushafSinglePageTile(
            constraints: widget.constraints,
            pageData: pages.pageData[index],
            isPortrait: widget.isPortrait,
            index: index,
          );
        }
      },
    );
  }
}
