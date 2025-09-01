import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar_item.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';
import 'package:mushaf_mistake_marker/providers/page_mode_provider.dart';

class DualPageItem extends ConsumerWidget {
  const DualPageItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (pageModeProv, isDualPage) = (
      ref.read(pageModeProvider.notifier),
      ref.watch(pageModeProvider),
    );

    final mushafPageCrtlProv = ref.read(mushafPgCtrlProvider.notifier);

    return NavBarItem(
      iconName: 'dualpage',
      isSelected: isDualPage,
      onTap: () {
        pageModeProv.setPageMode();
        final newIsDualPage = !isDualPage;
        mushafPageCrtlProv.preservePage(
          newIsDualPage ? PageLayout.dualPage : PageLayout.singlePage,
        );
      },
    );
  }
}
