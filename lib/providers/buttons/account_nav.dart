import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountNavBtnProvider = NotifierProvider<AccountNavBtnNotifier, bool>(
  AccountNavBtnNotifier.new,
);

class AccountNavBtnNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void switchBtnState() {
    state = !state;
  }
}
