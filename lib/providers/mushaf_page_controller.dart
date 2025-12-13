import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/main.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user_settings.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';
import 'package:mushaf_mistake_marker/providers/user/user.dart';

final mushafPgCtrlProvider =
    NotifierProvider<MushafPageControllerProvider, PageController>(
      MushafPageControllerProvider.new,
    );

class MushafPageControllerProvider extends Notifier<PageController> {
  @override
  PageController build() {
    final prefs = ref.read(sharedPrefsProv);
    final user = ref.read(userProvider);

    final isDualPageMode = prefs.getBool('isDualPageMode') ?? false;

    final initPage = user.settings.target!.initPage;

    final actualPage = isDualPageMode ? (initPage / 2).ceil() : initPage;

    final pageController = PageController(initialPage: actualPage);

    ref.onDispose(pageController.dispose);

    return pageController;
  }

  void setPage(int index) {
    final user = ref.read(userProvider);

    final settings = user.settings.target!;

    final settingBox = objectbox.store.box<UserSettings>();

    settings.initPage = index;

    settingBox.put(settings);
  }

  void preservePage(PageLayout targetLayout) {
    if (!state.hasClients) {
      return;
    }

    final pageIndex = state.page!.round();
    final isSinglePage = targetLayout == .singlePage;

    final int targetPage = isSinglePage ? pageIndex * 2 : pageIndex ~/ 2;

    state.jumpToPage(targetPage);

    final setInitPage = isSinglePage ? targetPage : targetPage * 2;

    setPage(setInitPage);
  }
}

enum PageLayout { singlePage, dualPage }
