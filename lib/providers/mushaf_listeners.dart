import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/dual_page_mode.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final mushafListenersProvider = Provider<void>((ref) {
  ref.listen<bool>(dualPageModeProvider, (_, _) {
    ref.read(mushafPgCtrlProvider.notifier).preservePage();
  });

  ref.listen<UserSettings?>(userSettingsProvider, (prev, next) {
    if (prev == null || next == null || prev.initPage == next.initPage) return;

    final dualPgMode = ref.read(dualPageModeProvider);

    final pgIndex = next.initPage;

    ref
        .read(mushafPgCtrlProvider)
        .jumpToPage(dualPgMode ? pgIndex ~/ 2 : pgIndex);

    ref.read(mushafPgCtrlProvider.notifier).setUserPage(pgIndex);

    ref.read(spriteProvider.notifier).clearAll();
  });
});
