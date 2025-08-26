import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_dual_page_tile.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_loading.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_pager.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_single_page_tile.dart';
import 'package:mushaf_mistake_marker/mushaf/page_changed_handler.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';
import 'package:mushaf_mistake_marker/providers/page_mode_provider.dart';
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

class _MushafPageViewState extends ConsumerState<MushafPageView>
    with AutomaticKeepAliveClientMixin {
  late final mushfaPgCrtl = ref.read(mushafPgCtrlProvider);
  late final initPage = mushfaPgCrtl.initialPage;
  late final prefs = ref.read(sharedPrefsProv);
  late int prevPage;
  late final onPgChngdHandler = PageChangedHandler();
  late final List<Map<String, MarkType>> markedPgs = List.generate(
    604,
    (_) => {},
    growable: false,
  );

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    preFetchPages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> preFetchPages() async {
    final isDualPageMode = ref.read(pageModeProvider) && !widget.isPortrait;
    final offsets = [0, 1, -1, 2, -2, 3, 4];
    final List<Future> futures = [];
    final List<int> pageNumbers = [];

    final actualPage = isDualPageMode ? initPage * 2 : initPage;
    prevPage = initPage;

    for (final e in offsets) {
      if (actualPage + e >= 0 && actualPage + e <= 603) {
        futures.add(SpriteManager.fetchSpriteSheet(actualPage + e));
        pageNumbers.add(actualPage + e);
      }
    }

    await Future.wait(futures);
    print(
      'Prefetched the following pages and their images: ${pageNumbers.join(',')}',
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDualPage = ref.watch(pageModeProvider);
    final isDualPageMode = isDualPage && !widget.isPortrait;
    prefs.setBool('isDualPageMode', isDualPageMode);

    return MushafPager(
      isDualPageMode: isDualPageMode,
      controller: mushfaPgCrtl,
      markedPgs: markedPgs,
      pages: widget.pages,
      constraints: widget.constraints,
      ref: ref,
      isPortrait: isDualPageMode ? false : widget.isPortrait,
    );
  }
}
