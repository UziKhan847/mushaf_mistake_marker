import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';

final accountNavBtnProvider = NotifierProvider<AccountNavBtnProvider, bool>(
  AccountNavBtnProvider.new,
);

class AccountNavBtnProvider extends Notifier<bool> {
  @override
  bool build() => ref.read(sharedPrefsProv).getBool('isAccountNavBtnSelected') ?? false;

  void switchBtnState() {
    final prefs = ref.read(sharedPrefsProv);
    state = !state;
    prefs.setBool('isAccountNavBtnSelected', state);
  }
}
