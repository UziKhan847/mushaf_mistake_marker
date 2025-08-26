import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';

final mushafPgCtrlProvider =
    NotifierProvider<MushafPageControllerProvider, PageController>(
      MushafPageControllerProvider.new,
    );

class MushafPageControllerProvider extends Notifier<PageController> {
  @override
  PageController build() {
    final prefs = ref.read(sharedPrefsProv);

    final isDualPageMode = prefs.getBool('isDualPageMode') ?? false;
    final initPage = prefs.getInt('initPage') ?? 0;
    final actualPage = isDualPageMode ? (initPage / 2).ceil() : initPage;

    final pageController = PageController(initialPage: actualPage);

    ref.onDispose(pageController.dispose);

    return pageController;
  }

  void setPage(int index) {
    final prefs = ref.read(sharedPrefsProv);
    prefs.setInt('initPage', index);
  }

  void preservePage(PageLayout targetLayout) {
    if (!state.hasClients) {
      return;
    }

    final pageIndex = state.page!.round();
    final isSinglePage = targetLayout == PageLayout.singlePage;

    final int targetPage = isSinglePage ? pageIndex * 2 : pageIndex ~/ 2;

    state.jumpToPage(targetPage);

    final setInitPage = isSinglePage ? targetPage : targetPage * 2;

    setPage(setInitPage);
  }
}

enum PageLayout { singlePage, dualPage }
