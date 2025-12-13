import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/add_user/form/builder.dart';
import 'package:mushaf_mistake_marker/add_user/success_builder.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/popup_card.dart';
import 'package:mushaf_mistake_marker/providers/add_user/error_message.dart';
import 'package:mushaf_mistake_marker/providers/add_user/phase.dart';
import 'package:mushaf_mistake_marker/providers/user/user.dart';

class AddUserCard extends ConsumerStatefulWidget {
  const AddUserCard({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    this.onCancel,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback? onCancel;

  @override
  ConsumerState<AddUserCard> createState() => _AddUserCardState();
}

class _AddUserCardState extends ConsumerState<AddUserCard> {
  //final _formKey = GlobalKey<FormState>();
  final textCtrl = TextEditingController();

  @override
  void dispose() {
    textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (phase, phaseProv) = (
      ref.watch(addUserPhaseProvider),
      ref.read(addUserPhaseProvider.notifier),
    );

    final errMsgProv = ref.read(addUserErrorMsgProvider.notifier);

    final userProv = ref.read(userProvider.notifier);
    final usernames = userProv.getUsernames(isLowerCase: true);

    return PopupCard(
      child: AnimatedSize(
        duration: Duration(milliseconds: 350),
        curve: Curves.decelerate,
        child: phase == .success
            ? AddUserSuccessBuilder(
                colorScheme: widget.colorScheme,
                textTheme: widget.textTheme,
              )
            : AddUserFormBuilder(
                colorScheme: widget.colorScheme,
                textTheme: widget.textTheme,
                //formKey: _formKey,
                textCtrl: textCtrl,
                phase: phase,
                onCancel: widget.onCancel,
                onSubmit: phase == .submitting
                    ? null
                    : () async {
                        if (phase == .error) {
                          phaseProv.setPhase(.initial);
                        }

                        final text = textCtrl.text.trim().toLowerCase();

                        String? error;

                        if (text.isEmpty) {
                          error = 'Please enter a username';
                        } else if (text.length < 3) {
                          error = 'Username must be at least 3 characters';
                        } else if (usernames.contains(text)) {
                          error = 'Username already in use.';
                        }

                        if (error != null) {
                          errMsgProv.setErrorMsg(error);
                          phaseProv.setPhase(.error);
                          return;
                        }

                        phaseProv.setPhase(.submitting);

                        final user = User(username: textCtrl.text);

                        try {
                          await userProv.saveUser(user);
                          phaseProv.setPhase(.success);
                        } catch (e) {
                          errMsgProv.setErrorMsg('$e');
                          //phaseProv.errorMsg('$e');
                          phaseProv.setPhase(.error);
                        }
                      },
              ),
      ),
    );
  }
}
