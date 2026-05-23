import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/page_mode.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/page_controller.dart';

final dualPageListenerProvider = Provider<void>((ref) {
  ref.listen<bool>(pageModeProvider, (prev, next) {
    if (prev == null || prev == next) return;
    ref.read(mushafPgCtrlProvider.notifier).preservePage();
  });
});
