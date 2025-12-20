import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';


final addUserPhaseProvider = NotifierProvider<AddUserPhaseNotifier, Phase>(
  AddUserPhaseNotifier.new,
);

class AddUserPhaseNotifier extends Notifier<Phase> {
  @override
  Phase build() => Phase.initial;

  void setPhase(Phase phase) {
    state = phase;
  }

  String? errorMsg(String? e) => e ?? 'Unkown error, please try again.';
}
