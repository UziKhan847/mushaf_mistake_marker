import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/add_user/form/buttons.dart';
import 'package:mushaf_mistake_marker/add_user/form/error.dart';
import 'package:mushaf_mistake_marker/add_user/form/text_field.dart';
import 'package:mushaf_mistake_marker/add_user/form/header.dart';
import 'package:mushaf_mistake_marker/enums.dart';

class AddUserFormBuilder extends StatelessWidget {
  const AddUserFormBuilder({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    //required this.formKey,
    required this.textCtrl,
    required this.phase,
    this.onCancel,
    this.onSubmit,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;
  //final GlobalKey<FormState> formKey;
  final TextEditingController textCtrl;
  final Phase phase;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 280, maxWidth: 420),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          AddUserHeader(
            colorScheme: colorScheme,
            textTheme: textTheme,
            onCancel: onCancel,
          ),

          const SizedBox(height: 6),

          Text(
            'Enter a username to add a new account. You can update additional details later.',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 16),

          AddUserTextField(
            //formKey: formKey,
            colorScheme: colorScheme,
            textTheme: textTheme,
            textCtrl: textCtrl,
          ),

          const SizedBox(height: 12),

          if (phase == .error) AddUserError(colorScheme: colorScheme),

          const SizedBox(height: 6),

          AddUserButtons(
            colorScheme: colorScheme,
            textTheme: textTheme,
            onCancel: onCancel,
            onSubmit: onSubmit,
          ),

          const SizedBox(height: 8),

          Text(
            'Only username is required for now.',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: .center,
          ),
        ],
      ),
    );
  }
}
