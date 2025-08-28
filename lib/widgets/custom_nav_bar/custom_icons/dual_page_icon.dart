import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';
import 'package:mushaf_mistake_marker/providers/page_mode_provider.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_icons/items_data.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_icons/sub_nav/sub_nav_bar_icon.dart';

class DualPageIcon extends ConsumerWidget {
  const DualPageIcon({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (pageModeProv, isDualPage) = (
      ref.read(pageModeProvider.notifier),
      ref.watch(pageModeProvider),
    );

    final mushafPageCrtlProv = ref.read(mushafPgCtrlProvider.notifier);

    return SubNavBarIcon(
      item: dualPage,
      isSelected: isDualPage,
      onTap: () {
        pageModeProv.setPageMode();
        final newIsDualPage = !isDualPage;
        mushafPageCrtlProv.preservePage(
          newIsDualPage ? PageLayout.dualPage : PageLayout.singlePage,
        );
      },
      showIndicator: true,
      indicatorOnColor: Colors.blue,
      indicatorOffColor: Colors.grey.shade300,
    );
  }
}
