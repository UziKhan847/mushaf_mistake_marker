import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageModeChangedProvider = NotifierProvider<IsDualPageModeNotifier, bool>(
  IsDualPageModeNotifier.new,
);

class IsDualPageModeNotifier extends Notifier<bool> {
  @override
  bool build() => false; 

  void setValue(bool value) {
    state = value;
  }
}
