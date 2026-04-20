import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/add_user/bottom_sheet_tile.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/bottom_side_sheet.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/user.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/user_account/user_account_tile.dart';
import 'package:mushaf_mistake_marker/widgets/sheets/bottom_side_sheet_header.dart';

class AccountsSheet extends ConsumerWidget {
  const AccountsSheet({super.key, this.elevation = 4.0, this.borderRadius});

  final double elevation;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider).id;
    final users = ref.read(userBoxProvider).getAll();
    final isPortrait = MediaQuery.orientationOf(context) == .portrait;

    return BottomSideSheetOverlay(
      elevation: elevation,
      borderRadius: borderRadius,
      child: Flex(
        direction: isPortrait ? .vertical : .horizontal,
        children: [
          BottomSideSheetDragHandle(),
          Expanded(
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
                      const Divider(height: 4),
                      UserAccountTile(
                        isSelected: id == userId,
                        user: user,
                        userSettings: settings,
                      ),
                    ],
                  );
                }
                return const AddUserBtmSheetTile();
              },
            ),
          ),
        ],
      ),
    );
  }
}
