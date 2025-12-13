import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/add_user/error_message.dart';

class AddUserError extends ConsumerWidget {
  const AddUserError({super.key, required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errMsg = ref.read(addUserErrorMsgProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colorScheme.error, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(errMsg, style: TextStyle(color: colorScheme.error)),
          ),
        ],
      ),
    );
  }
}
