import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/bottom_side_sheet_overlay.dart';
import 'package:mushaf_mistake_marker/providers/buttons/account_nav.dart';

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
            BottomSideSheetOverlay(),
          ],
        );
      },
      selectedAsset: MyFlutterApp.account,
      unselectedAsset: MyFlutterApp.account_outlined,
      iconLabel: 'Account',
    );
  }
}
