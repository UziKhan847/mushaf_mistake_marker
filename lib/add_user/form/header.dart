import 'package:flutter/material.dart';

class AddUserHeader extends StatelessWidget {
  const AddUserHeader({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    required this.onCancel,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Add account',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),

        IconButton(
          onPressed: onCancel,
          tooltip: 'Close',
          icon: Icon(Icons.close, color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
