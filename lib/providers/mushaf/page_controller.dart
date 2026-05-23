import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/page_mode.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/settings.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final mushafPgCtrlProvider =
    NotifierProvider<MushafPageControllerProvider, PageController>(
      MushafPageControllerProvider.new,
    );

class MushafPageControllerProvider extends Notifier<PageController> {
  @override
  PageController build() {
    //final prefs = ref.read(sharedPrefsProv);
    final user = ref.read(userProvider);
    final dualPgMode = ref.read(pageModeProvider);

    final initPage = user.settings.target!.initPage;

    final actualPage = dualPgMode ? (initPage / 2).ceil() : initPage;

    final pageController = PageController(initialPage: actualPage);

    ref.onDispose(pageController.dispose);

    return pageController;
  }

  void preservePage() {
    if (!state.hasClients) return;

    final dualPgMode = ref.read(pageModeProvider);
    final pageIndex = state.page!.round();
    final targetPage = dualPgMode ? pageIndex ~/ 2 : pageIndex * 2;

    state.jumpToPage(targetPage);
    final setInitPage = dualPgMode ? targetPage * 2 : targetPage;
    setUserPage(setInitPage);
  }

  void setUserPage(int index) {
    final settings = ref.read(userSettingsProvider);
    final settingsBox = ref.read(settingsBoxProvider);

    settings!.initPage = index;

    settingsBox.put(settings);
  }

  void navigateToPage({required int targetUserPage, required int targetIndex}) {
    ref.read(spriteProvider.notifier).clearExcept(targetUserPage);
    setUserPage(targetUserPage);
    state.jumpToPage(targetIndex);
  }

  void navigateToPageUponChangingUser(int targetUserPage) {
    final dualPgMode = ref.read(pageModeProvider);
    final targetIndex = dualPgMode ? targetUserPage ~/ 2 : targetUserPage;

    navigateToPage(targetUserPage: targetUserPage, targetIndex: targetIndex);
  }
}
