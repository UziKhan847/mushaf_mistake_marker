import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.submitting,
    required this.onSubmit,
    required this.colorScheme,
    required this.textTheme,
  });

  final bool submitting;
  final VoidCallback? onSubmit;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: submitting ? null : onSubmit,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: .circular(10)),
        padding: const .symmetric(vertical: 14),
      ),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 220),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: submitting
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2.2),
              )
            : Row(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.add, size: 18, color: colorScheme.onPrimary),
                  const SizedBox(width: 8),
                  Text(
                    'Add account',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
