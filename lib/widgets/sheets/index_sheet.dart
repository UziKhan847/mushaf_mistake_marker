import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/bottom_side_sheet.dart';
import 'package:mushaf_mistake_marker/widgets/index/tab_view.dart';

class IndexSheet extends StatefulWidget {
  const IndexSheet({super.key});

  @override
  State<IndexSheet> createState() => _IndexSheetState();
}

class _IndexSheetState extends State<IndexSheet>
    with SingleTickerProviderStateMixin {
  late final TabController tabCtrl;

  @override
  void initState() {
    super.initState();
    tabCtrl = TabController(length: IndexTab.values.length, vsync: this);
  }

  @override
  void dispose() {
    tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabCtrl,
          isScrollable: true,
          tabAlignment: .start,
          padding: const .symmetric(horizontal: 12),
          tabs: IndexTab.values
              .map(
                (tab) => Tab(
                  child: Row(
                    mainAxisSize: .min,
                    children: [
                      Icon(tab.icon, size: 16),
                      const SizedBox(width: 6),
                      Text(tab.label),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 4),
        const Divider(height: 1),
        Expanded(
          child: TabBarView(
            controller: tabCtrl,
            children: IndexTab.values
                .map((tab) => IndexTabView(tab: tab))
                .toList(),
          ),
        ),
      ],
    );
  }
}
