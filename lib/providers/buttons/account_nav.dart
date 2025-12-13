import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountNavBtnProvider = NotifierProvider<AccountNavBtnProvider, bool>(
  AccountNavBtnProvider.new,
);

class AccountNavBtnProvider extends Notifier<bool> {
  @override
  bool build() => false;

  void switchBtnState() {
    state = !state;
  }
}
