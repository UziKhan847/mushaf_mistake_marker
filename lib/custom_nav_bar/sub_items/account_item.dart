import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar_item.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/tiles/account_user_tile.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/tiles/add_user_tile.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/main.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/providers/buttons/account_nav_btn_provider.dart';

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
          itemCount: users.length + 1,
          itemBuilder: (context, index) {
            final colorScheme = Theme.of(context).colorScheme;
            final textTheme = Theme.of(context).textTheme;

            if (index < users.length) {
              final user = users[index];
              final userSettings = user.settings.target!;

              return AccountUserTile(
                colorScheme: colorScheme,
                textTheme: textTheme,
                user: user,
                userSettings: userSettings,
              );
            }

            return AddUserTile(colorScheme: colorScheme, textTheme: textTheme);
          },
          isStatic: true,
        );
      },
      selectedAsset: MyFlutterApp.account,
      unselectedAsset: MyFlutterApp.account_outlined,
      iconLabel: 'Account',
    );
  }
}
