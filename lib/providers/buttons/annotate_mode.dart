import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';

final annotateModeProvider =
    NotifierProvider<AnnotateModeNotifier, AnnotationMode>(
      AnnotateModeNotifier.new,
    );

class AnnotateModeNotifier extends Notifier<AnnotationMode> {
  @override
  AnnotationMode build() {
    final prefs = ref.read(sharedPrefsProv);
    final id = prefs.getInt('annotationMode');
    return AnnotationMode.fromId(id);
  }

  void setMode(AnnotationMode mode) {
    final prefs = ref.read(sharedPrefsProv);
    state = mode;
    prefs.setInt('annotationMode', mode.id);
  }
}
