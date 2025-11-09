import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar_item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/providers/account_nav_btn_provider.dart';

class AccountItem extends ConsumerWidget {
  const AccountItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (accNavBarProv, isAccBtnSelected) = (
      ref.read(accountNavBtnProvider.notifier),
      ref.watch(accountNavBtnProvider),
    );

    return NavBarItem(
      isSelected: isAccBtnSelected,
      onTap: () {
        accNavBarProv.switchBtnState();
      },
      selectedAsset: MyFlutterApp.account,
      unselectedAsset: MyFlutterApp.account_outlined,
      iconLabel: 'Account',
    );
  }
}
