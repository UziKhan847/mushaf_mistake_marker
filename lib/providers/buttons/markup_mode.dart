import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';

final markupModeProvider = NotifierProvider<MarkUpModeNotifier, MarkupMode>(
  MarkUpModeNotifier.new,
);

class MarkUpModeNotifier extends Notifier<MarkupMode> {
  @override
  MarkupMode build() =>
      MarkupMode.fromId(ref.read(sharedPrefsProv).getInt('markupMode'));

  void switchMarkupMode(MarkupMode markupModeType) {
    final prefs = ref.read(sharedPrefsProv);
    state = markupModeType;
    prefs.setInt('markupMode', markupModeType.id);
  }
}
