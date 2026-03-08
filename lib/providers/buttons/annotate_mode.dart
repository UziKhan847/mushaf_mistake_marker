import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';

final annotateModeProvider = NotifierProvider<AnnotateModeNotifier, bool>(
  AnnotateModeNotifier.new,
);

class AnnotateModeNotifier extends Notifier<bool> {
  @override
  bool build() => ref.read(sharedPrefsProv).getBool('annotateMode') ?? true;

  void switchMode(bool isAnnotateMode) {
    final prefs = ref.read(sharedPrefsProv);
    state = isAnnotateMode;
    prefs.setBool('annotateMode', isAnnotateMode);
  }
}
