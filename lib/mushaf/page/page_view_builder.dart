import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/tiles/dual_page.dart';
import 'package:mushaf_mistake_marker/mushaf/tiles/single_page.dart';
import 'package:mushaf_mistake_marker/mushaf/page/changed_handler.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/is_dual_page_mode.dart';
import 'package:mushaf_mistake_marker/providers/on_page_mode_changed.dart';
import 'package:mushaf_mistake_marker/providers/page_mode.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/page_controller.dart';
import 'package:mushaf_mistake_marker/providers/pages_provider.dart';

class MushafPageViewBuilder extends ConsumerStatefulWidget {
  const MushafPageViewBuilder({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  ConsumerState<MushafPageViewBuilder> createState() => _MushafPagerState();
}

class _MushafPagerState extends ConsumerState<MushafPageViewBuilder>
    with AutomaticKeepAliveClientMixin {
  late int prevPage;
  late final onPageHandler = PageChangedHandler(ref: ref);
  late final pages = ref.read(pagesProvider).value!;
  late final mshfPgCtrl = ref.read(mushafPgCtrlProvider);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    prevPage = mshfPgCtrl.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final dualPgMode = ref.watch(pageModeProvider);

    return PageView.builder(
      reverse: true,
      controller: mshfPgCtrl,
      onPageChanged: (int index) async {
        final isSwipe = (index - prevPage).abs() == 1;
        // final pageModeChanged = ref.read(pageModeChangedProvider);

        if (!isSwipe) {
          prevPage = index;
          // ref.read(pageModeChangedProvider.notifier).setValue(false);
          return;
        }

        prevPage = await onPageHandler.onPageSwipe(prevPage, index, dualPgMode);
      },
      itemCount: dualPgMode ? 302 : 604,
      itemBuilder: (_, index) {
        if (dualPgMode) {
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
            index: index,
          );
        }
      },
    );
  }
}
