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

    final pageController = PageController(
      initialPage: prefs.getInt('initPage') ?? 0,
    );

    ref.onDispose(pageController.dispose);

    return pageController;
  }

  void setPage(int index, bool isDualPageMode) {
    final prefs = ref.read(sharedPrefsProv);
    final newPage = isDualPageMode ? (index / 2).floor() : index;
    // print('----------------------------');
    // print('THE DUAL PAGE NUMBER: ${(index / 2).floor()}');
    // print('THE SINGLE PAGE NUMBER: $index');
    // print('----------------------------');
    prefs.setInt('initPage', newPage);
  }
}
