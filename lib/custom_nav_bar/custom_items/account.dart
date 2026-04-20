import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/icons/mushaf_app_icons_icons.dart';
import 'package:mushaf_mistake_marker/widgets/sheets/accounts_sheet.dart';
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
    final accNavBarProv = ref.read(accountNavBtnProvider.notifier);
    final isSelected = ref.watch(accountNavBtnProvider);
    final cs = Theme.of(context).colorScheme;

    return NavBarItem(
      isSelected: isSelected,
      iconLabel: 'Account',
      onTap: () {
        overlay = context.insertAnimatedOverlay(
          backdropOn: true,
          modalBarrierOn: true,
          onTapOutside: () {
            accNavBarProv.switchBtnState();
            context.removeOverlayEntry(overlay);
          },
          children: [AccountsSheet()],
        );
      },
      child: Icon(
        isSelected ? MushafAppIcons.account : MushafAppIcons.account_outlined,
        color: isSelected ? cs.primary : cs.onSurfaceVariant,
      ),
    );
  }
}
