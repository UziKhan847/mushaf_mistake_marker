import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar_item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';
import 'package:mushaf_mistake_marker/providers/buttons/dual_page_toggle_provider.dart';

class DualPageItem extends ConsumerWidget {
  const DualPageItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (dualPgTglProv, isDualPgTglOn) = (
      ref.read(dualPageToggleProvider.notifier),
      ref.watch(dualPageToggleProvider),
    );

    final mushafPageCrtlProv = ref.read(mushafPgCtrlProvider.notifier);

    return NavBarItem(
      iconLabel: 'Dual Page',
      isSelected: isDualPgTglOn,
      onTap: () {
        dualPgTglProv.switchToggle();
        final newIsDualPage = !isDualPgTglOn;
        mushafPageCrtlProv.preservePage(
          newIsDualPage ? PageLayout.dualPage : PageLayout.singlePage,
        );
      }, selectedAsset: MyFlutterApp.dual_page, unselectedAsset: MyFlutterApp.dual_page_outlined,
    );
  }
}
