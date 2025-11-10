import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';

final highlightProvider = NotifierProvider<HighlighterProvider, bool>(
  HighlighterProvider.new,
);

class HighlighterProvider extends Notifier<bool> {
  @override
  bool build() => ref.read(sharedPrefsProv).getBool('isHighlightMode') ?? false;

  void switchColorMode() {
    final prefs = ref.read(sharedPrefsProv);
    state = !state;
    prefs.setBool('isHighlightMode', state);
  }
}
