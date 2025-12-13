import 'package:flutter_riverpod/flutter_riverpod.dart';

final addUserErrorMsgProvider =
    NotifierProvider<AddUserErrorMsgNotifier, String>(
      AddUserErrorMsgNotifier.new,
    );

class AddUserErrorMsgNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setErrorMsg(String? msg) {
    state = msg ?? '';
  }
}
