import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';

final singlePgCrtlProvider =
    NotifierProvider<SinglePageControllerProvider, PageController>(
      SinglePageControllerProvider.new,
    );

class SinglePageControllerProvider extends Notifier<PageController> {
  @override
  PageController build() {
    final prefs = ref.read(sharedPrefsProv);

    final pageController = PageController(
      initialPage: prefs.getInt('initPage') ?? 0,
    );

    ref.onDispose(pageController.dispose);

    return pageController;
  }

  void setPage(int index, bool isDualPageMode) {
    final prefs = ref.read(sharedPrefsProv);
    final pageIndex = isDualPageMode ? index * 2 : index;
    prefs.setInt('initPage', pageIndex);
  }
}
