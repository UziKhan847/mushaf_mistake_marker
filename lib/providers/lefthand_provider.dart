import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';

final leftHandProvider = NotifierProvider<LefthandProvider, bool>(
  LefthandProvider.new,
);

class LefthandProvider extends Notifier<bool> {
  @override
  bool build() => ref.read(sharedPrefsProv).getBool('isLeftHand') ?? false;

  void switchHandMode() {
    final prefs = ref.read(sharedPrefsProv);
    state = !state;
    prefs.setBool('isLeftHand', state);
  }
}

