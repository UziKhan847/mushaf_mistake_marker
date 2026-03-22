import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/widgets/buttons/cancel.dart';
import 'package:mushaf_mistake_marker/widgets/buttons/submit.dart';

class AddUserButtons extends StatelessWidget {
  const AddUserButtons({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    required this.onCancel,
    this.onSubmit,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;

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
            onSubmit: onSubmit,
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),
        ),
      ],
    );
  }
}
