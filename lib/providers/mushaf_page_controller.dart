import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/providers/dual_page_mode.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/settings.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/user.dart';

final mushafPgCtrlProvider =
    NotifierProvider<MushafPageControllerProvider, PageController>(
      MushafPageControllerProvider.new,
    );

class MushafPageControllerProvider extends Notifier<PageController> {
  @override
  PageController build() {
    final (prefs, user, dualPgMode) = (
      ref.read(sharedPrefsProv),
      ref.read(userProvider),
      ref.read(dualPageModeProvider),
    );

    final initPage = user.settings.target!.initPage;

    final actualPage = dualPgMode ? (initPage / 2).ceil() : initPage;

    final pageController = PageController(initialPage: actualPage);

    ref.onDispose(pageController.dispose);

    return pageController;
  }

  void setUserPage(int index) {
    final (settings, settingsBox) = (
      ref.read(userSettingsProvider),
      ref.read(settingsBoxProvider),
    );

    settings!.initPage = index;

    settingsBox.put(settings);
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

    setUserPage(setInitPage);
  }
}
