import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/widgets/cancel_button.dart';
import 'package:mushaf_mistake_marker/widgets/submit_button.dart';

class AddUserButtons extends StatelessWidget {
  const AddUserButtons({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    required this.onCancel,
    required this.submitting,
    this.onSubmit,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final bool submitting;
  final void Function()? onCancel;
  final void Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: CancelButton(onCancel: onCancel, colorScheme: colorScheme),
        ),
        Expanded(
          child: SubmitButton(
            submitting: submitting,
            onSubmit: onSubmit,
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),
        ),
      ],
    );
  }
}
