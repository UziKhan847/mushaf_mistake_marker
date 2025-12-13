import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';

final dualPageToggleProvider = NotifierProvider<DualPageToggleNotifer, bool>(
  DualPageToggleNotifer.new,
);

class DualPageToggleNotifer extends Notifier<bool> {
  @override
  bool build() => ref.read(sharedPrefsProv).getBool('dualPageToggleOn') ?? false;

  void switchToggle() {
    final prefs = ref.read(sharedPrefsProv);
    state = !state;
    prefs.setBool('dualPageToggleOn', state);
  }
}
