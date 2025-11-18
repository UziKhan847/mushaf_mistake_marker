import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/add_user/popup_card.dart';

class AddUserBtmSheetTile extends StatefulWidget {
  const AddUserBtmSheetTile({
    super.key,
    required this.colorScheme,
    required this.textTheme,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  State<AddUserBtmSheetTile> createState() => _AddUserBtmSheetTileState();
}

class _AddUserBtmSheetTileState extends State<AddUserBtmSheetTile> {
  OverlayEntry? overlay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Material(
          color: widget.colorScheme.surface,
          child: InkWell(
            onTap: () {
              overlay = context.insertOverlay(
                onTapOutside: () {
                  context.removeOverlayEntry(overlay);
                },
                children: [
                  AddUserPopupCard(
                    onCancel: () {
                      context.removeOverlayEntry(overlay);
                    }, child: null, colorScheme: widget.colorScheme, textTheme: widget.textTheme,
                  ),
                ],
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: widget.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: widget.colorScheme.onPrimaryContainer,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Add account',
                          style: widget.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Sign in or create another account',
                          style: widget.textTheme.bodySmall?.copyWith(
                            color: widget.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.chevron_right,
                    color: widget.colorScheme.onSurfaceVariant,
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
