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

  BorderRadiusGeometry getBorderRadius(bool isPortrait, Radius radius) => .only(
    topLeft: radius,
    topRight: isPortrait ? radius : .zero,
    bottomLeft: isPortrait ? .zero : radius,
  );

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
      top: isPortrait ? null : (scrSize.height - (scrSize.height - 50)) / 2,
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
              if (index < users.length) {
                final user = users[index];
                final id = user.id;
                final settings = user.settings.target!;

                return Column(
                  children: [
                    Divider(height: 4),
                    UserAccountTile(
                      isSelected: id == userId,
                      user: user,
                      userSettings: settings,
                    ),
                  ],
                );
              }

              return AddUserBtmSheetTile();
            },
          ),
        ),
      ),
    );
  }
}
