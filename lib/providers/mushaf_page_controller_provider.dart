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

    print('---------------------------');
    print('INITIAL PAGE: $initPage');
    print('---------------------------');

    print('---------------------------');
    print('ACTUAL PAGE: $actualPage');
    print('---------------------------');

    final pageController = PageController(initialPage: actualPage);

    ref.onDispose(pageController.dispose);

    return pageController;
  }

  void setPage(int index) {
    final prefs = ref.read(sharedPrefsProv);
    prefs.setInt('initPage', index);
  }
}
