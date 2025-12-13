import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/add_user/phase.dart';

class SubmitButton extends ConsumerWidget {
  const SubmitButton({
    super.key,
    required this.onSubmit,
    required this.colorScheme,
    required this.textTheme,
  });

  final VoidCallback? onSubmit;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phase = ref.read(addUserPhaseProvider);

    return ElevatedButton(
      onPressed: onSubmit,
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
        child: phase == .submitting
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2.2),
              )
            : Row(
                mainAxisAlignment: .center,
                spacing: 8,
                children: [
                  Icon(Icons.add, size: 18, color: colorScheme.onPrimary),
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
