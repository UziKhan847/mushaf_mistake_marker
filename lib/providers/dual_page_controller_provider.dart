import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';

final dualPgCrtlProvider =
    NotifierProvider<DualPageControllerProvider, PageController>(
      DualPageControllerProvider.new,
    );

class DualPageControllerProvider extends Notifier<PageController> {
  @override
  PageController build() {
    final prefs = ref.read(sharedPrefsProv);

    final singlePageIndex = prefs.getInt('initPage') ?? 0;
    final dualPageIndex = (singlePageIndex / 2).floor();

    final pageController = PageController(initialPage: dualPageIndex);

    ref.onDispose(pageController.dispose);

    return pageController;
  }

  // void setPage(int index) {
  //   final prefs = ref.read(sharedPrefsProv);
  //   prefs.setInt('initPage', index);
  // }
}
