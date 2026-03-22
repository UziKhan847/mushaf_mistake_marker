import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/add_user/card.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/providers/add_user/phase.dart';

class AddUserBtmSheetTile extends ConsumerStatefulWidget {
  const AddUserBtmSheetTile({super.key});

  @override
  ConsumerState<AddUserBtmSheetTile> createState() =>
      _AddUserBtmSheetTileState();
}

class _AddUserBtmSheetTileState extends ConsumerState<AddUserBtmSheetTile> {
  OverlayEntry? overlay;

  void onCancel() {
    context.removeOverlayEntry(overlay);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Divider(),
        Material(
          color: colorScheme.surface,
          child: InkWell(
            onTap: () {
              ref.read(addUserPhaseProvider.notifier).setPhase(.initial);
              overlay = context.insertAnimatedOverlay(
                backdropOn: true,
                modalBarrierOn: true,
                onTapOutside: () {
                  context.removeOverlayEntry(overlay);
                },
                children: [
                  AddUserCard(
                    onCancel: onCancel,
                  ),
                ],
              );
            },
            child: Padding(
              padding: const .symmetric(horizontal: 24.0, vertical: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        Text(
                          'Add account',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: .w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Sign in or create another account',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
