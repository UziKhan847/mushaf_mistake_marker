import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/page_mode.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/page_controller.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/settings.dart';

final mushafListenersProvider = Provider<void>((ref) {
  ref.listen<bool>(pageModeProvider, (prev, next) {
    if (prev == null || prev == next) return;

    // ref.read(pageModeChangedProvider.notifier).setValue(true);
    ref.read(mushafPgCtrlProvider.notifier).preservePage();
  });

  ref.listen<UserSettings?>(userSettingsProvider, (prev, next) {
    if (prev == null || next == null || prev.initPage == next.initPage) return;

    final dualPgMode = ref.read(pageModeProvider);
    final targetUserPage = next.initPage;
    final targetIndex = dualPgMode ? targetUserPage ~/ 2 : targetUserPage;
    final difference = (next.initPage - prev.initPage).abs();
    final isSwipe = dualPgMode ? difference == 2 : difference == 1;

    ref
        .read(mushafPgCtrlProvider.notifier)
        .navigateToPage(
          targetUserPage: targetUserPage,
          targetIndex: targetIndex,
          isSwipe: isSwipe,
        );
  });
});
