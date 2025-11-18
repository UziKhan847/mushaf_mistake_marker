import 'package:flutter/material.dart';

class AddUserPopupCard extends StatelessWidget {
  const AddUserPopupCard({
    super.key,
    this.initUsername = '',
    required this.onCancel,
    required this.child,
    required this.colorScheme,
    required this.textTheme,
  });

  final String initUsername;
  final VoidCallback onCancel;
  final Widget? child;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420, minWidth: 280),
        child: Material(
          color: colorScheme.surface,
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedSize(
              duration: Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
