import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/add_user/bottom_sheet_tile.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/user.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/user_account/user_account_tile.dart';

class BottomSideSheetOverlay extends ConsumerWidget {
  const BottomSideSheetOverlay({
    super.key,
    this.elevation = 4.0,
    this.borderRadius,
  });

  final double elevation;
  final BorderRadiusGeometry? borderRadius;

  double getTop(Size scrSize) => (scrSize.height - (scrSize.height - 50)) / 2;

  BorderRadiusGeometry getBorderRadius(bool isPortrait, Radius radius) =>
      isPortrait
      ? BorderRadius.only(topLeft: radius, topRight: radius)
      : .only(topLeft: radius, bottomLeft: radius);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider).id;
    final users = ref.read(userBoxProvider).getAll();

    final radius = Radius.circular(20);
    final mediaQ = MediaQuery.of(context);

    final scrSize = mediaQ.size;
    final isPortrait = mediaQ.orientation == .portrait;

    return Positioned(
      right: isPortrait ? null : 0,
      bottom: isPortrait ? 0 : null,
      top: isPortrait ? null : getTop(scrSize),
      child: Material(
        clipBehavior: .hardEdge,
        elevation: elevation,
        borderRadius: borderRadius ?? getBorderRadius(isPortrait, radius),
        color: Theme.of(context).colorScheme.surface,
        child: SizedBox(
          width: isPortrait ? scrSize.width : scrSize.height,
          height: isPortrait ? (scrSize.height - 50) / 2 : scrSize.height - 50,
          child: ListView.builder(
            padding: .zero,
            itemCount: users.length + 1,
            itemBuilder: (context, index) {
              final colorScheme = Theme.of(context).colorScheme;
              final textTheme = Theme.of(context).textTheme;

              if (index < users.length) {
                final user = users[index];
                final id = user.id;
                final settings = user.settings.target!;

                return Column(
                  children: [
                    Divider(height: 4),
                    UserAccountTile(
                      isSelected: id == userId,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                      user: user,
                      userSettings: settings,
                    ),
                  ],
                );
              }

              return AddUserBtmSheetTile(
                colorScheme: colorScheme,
                textTheme: textTheme,
              );
            },
          ),
        ),
      ),
    );
  }
}
