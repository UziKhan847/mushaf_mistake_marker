import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/user.dart';

class UserAccountTile extends ConsumerWidget {
  const UserAccountTile({
    super.key,
    required this.user,
    required this.userSettings,
    required this.isSelected,
  });

  final bool isSelected;
  final User user;
  final UserSettings userSettings;

  String formatDate(int ms) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ms);
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final userProv = ref.read(userProvider.notifier);

    final backgroundColor = isSelected
        ? colorScheme.secondaryContainer.withAlpha(80)
        : colorScheme.surface;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          left: BorderSide(
            color: isSelected ? colorScheme.primary : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          if (!isSelected) userProv.setUser(user);
        },
        child: Padding(
          padding: const .symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(
                  Icons.account_circle_rounded,
                  size: 26,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Text(
                      user.username,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: .w600,
                      ),
                      overflow: .ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.history,
                          size: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Page: ${userSettings.initPage + 1}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formatDate(userSettings.updatedAt),
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                tooltip: 'Account options',
                icon: Icon(
                  Icons.more_vert,
                  color: colorScheme.onSurfaceVariant,
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
    );
  }
}