import 'package:flutter/material.dart';

class AddUserSuccessBuilder extends StatelessWidget {
  const AddUserSuccessBuilder({
    super.key,
    required this.colorScheme,
    required this.textTheme,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 280, maxWidth: 420),
      child: Column(
        mainAxisSize: .min,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(46),
              shape: .circle,
            ),
            child: Icon(Icons.check, size: 44, color: colorScheme.primary),
          ),
          const SizedBox(height: 12),
          Text(
            'Account created',
            style: textTheme.titleMedium?.copyWith(fontWeight: .w600),
          ),
          const SizedBox(height: 6),
          Text(
            'You can edit details later.',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
