import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/add_user/bottom_sheet_tile.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/user_account/user_account_tile.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/main.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/bottom_side_sheet_overlay.dart';
import 'package:mushaf_mistake_marker/providers/buttons/account_nav_btn_provider.dart';
import 'package:mushaf_mistake_marker/providers/user/user_id_provider.dart';

class AccountItem extends ConsumerStatefulWidget {
  const AccountItem({super.key});

  @override
  ConsumerState<AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends ConsumerState<AccountItem> {
  OverlayEntry? overlay;

  @override
  Widget build(BuildContext context) {
    final (accNavBarProv, isAccBtnSelected) = (
      ref.read(accountNavBtnProvider.notifier),
      ref.watch(accountNavBtnProvider),
    );

    final userId = ref.watch(userIdProvider);

    final users = objectbox.store.box<User>().getAll();

    return NavBarItem(
      isSelected: isAccBtnSelected,
      onTap: () {
        accNavBarProv.switchBtnState();
        overlay = context.insertOverlay(
          onTapOutside: () {
            accNavBarProv.switchBtnState();
            context.removeOverlayEntry(overlay);
          },
          children: [
            BottomSideSheetOverlay(
              itemCount: users.length + 1,
              itemBuilder: (context, index) {
                final colorScheme = Theme.of(context).colorScheme;
                final textTheme = Theme.of(context).textTheme;

                if (index < users.length) {
                  final user = users[index];
                  final userSettings = user.settings.target!;

                  return UserAccountTile(
                    isSelected: user.id == userId,
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                    user: user,
                    userSettings: userSettings,
                  );
                }

                return AddUserBtmSheetTile(
                  colorScheme: colorScheme,
                  textTheme: textTheme,
                );
              },
            ),
          ],
        );
      },
      selectedAsset: MyFlutterApp.account,
      unselectedAsset: MyFlutterApp.account_outlined,
      iconLabel: 'Account',
    );
  }
}
