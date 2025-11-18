import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user_settings.dart';

class UserAccountTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final backgroundColor = isSelected
        ? colorScheme.primary.withAlpha(25)
        : colorScheme.surface;
    final elevation = isSelected ? 2.0 : 0.0;
    final usernameColor = isSelected ? colorScheme.primary : null;
    final accentColor = colorScheme.primary;
    final onAccent = colorScheme.onPrimary;

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: isSelected ? 6 : 6,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isSelected ? accentColor : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Stack(
                  clipBehavior: Clip.none,
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: accentColor,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.check, size: 14, color: onAccent),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              user.username,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: usernameColor,
                              ),
                              overflow: TextOverflow.ellipsis,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer.withAlpha(
                                50,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
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
