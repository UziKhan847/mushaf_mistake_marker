import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';

final darkModeProvider = NotifierProvider<DarkModeNotifier, bool>(DarkModeNotifier.new);

class DarkModeNotifier extends Notifier<bool> {
  @override
  bool build() => ref.read(sharedPrefsProv).getBool('isDarkMode') ?? false;

  void switchTheme() {
    final prefs = ref.read(sharedPrefsProv);
    state = !state;
    prefs.setBool('isDarkMode', state);
  }
}
