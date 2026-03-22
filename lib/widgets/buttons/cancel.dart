import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
    required this.onCancel,
    required this.colorScheme,
  });

  final VoidCallback? onCancel;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onCancel,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: colorScheme.surfaceContainerHighest),
        shape: RoundedRectangleBorder(borderRadius: .circular(10)),
      ),
      child: Text(
        'Cancel',
        style: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
    );
  }
}
