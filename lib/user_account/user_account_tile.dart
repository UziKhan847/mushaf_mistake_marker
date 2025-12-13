import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/page/page_changed_handler.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user_settings.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller.dart';
import 'package:mushaf_mistake_marker/providers/user/id.dart';

class UserAccountTile extends ConsumerWidget {
  const UserAccountTile({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    required this.user,
    required this.userSettings,
    required this.isSelected,
  });

  final bool isSelected;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final User user;
  final UserSettings userSettings;

  String formatDate(int ms) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ms);
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIdProv = ref.read(userIdProvider.notifier);
    final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider);
    final onPgChgHandler = PageChangedHandler(ref: ref);

    final userLastPage = userSettings.initPage;

    final backgroundColor = isSelected
        ? colorScheme.secondaryContainer.withAlpha(100)
        : colorScheme.surface;
    final elevation = isSelected ? 2.0 : 0.0;
    final usernameColor = isSelected ? colorScheme.primary : null;
    final accentColor = colorScheme.primary;
    final onAccent = colorScheme.onPrimary;

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: .circular(8)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: .circular(8),
        ),
        child: InkWell(
          onTap: () {
            userIdProv.setUserId(user.id);
            mushafPgCtrlProv.jumpToPage(userLastPage);
            onPgChgHandler.onJumpToPage(userLastPage);
          },
          borderRadius: .circular(8),
          child: Padding(
            padding: const .symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: .center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: isSelected ? 6 : 6,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isSelected ? accentColor : Colors.transparent,
                    borderRadius: const .only(
                      topLeft: .circular(6),
                      bottomLeft: .circular(6),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Stack(
                  clipBehavior: .none,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: isSelected
                          ? colorScheme.primaryContainer
                          : colorScheme.primaryContainer,
                      child: Icon(
                        Icons.account_circle_rounded,
                        size: 28,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),

                    if (isSelected)
                      Positioned(
                        right: -6,
                        bottom: -6,
                        child: Material(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(12),
                          ),
                          color: accentColor,
                          child: Padding(
                            padding: const .all(4.0),
                            child: Icon(Icons.check, size: 14, color: onAccent),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              user.username,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: .w700,
                                color: usernameColor,
                              ),
                              overflow: .ellipsis,
                            ),
                          ),

                          IconButton(
                            onPressed: () {},
                            tooltip: 'Open profile actions',
                            icon: Icon(
                              Icons.more_vert,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        crossAxisAlignment: .center,
                        children: [
                          Container(
                            padding: const .symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer.withAlpha(
                                50,
                              ),
                              borderRadius: .circular(20),
                            ),
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Icon(
                                  Icons.history,
                                  size: 16,
                                  color: colorScheme.secondary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${userSettings.initPage + 1}',
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          Text(
                            'Created: ${formatDate(userSettings.updatedAt)}',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
