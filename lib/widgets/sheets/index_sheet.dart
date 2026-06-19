import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/providers/index/stats_lists.dart';
import 'package:mushaf_mistake_marker/widgets/index/pages_tab_view.dart';
import 'package:mushaf_mistake_marker/widgets/index/tab_view.dart';

class IndexSheet extends ConsumerStatefulWidget {
  const IndexSheet({super.key});
  @override
  ConsumerState<IndexSheet> createState() => _IndexSheetState();
}

class _IndexSheetState extends ConsumerState<IndexSheet>
    with SingleTickerProviderStateMixin {
  late final TabController tabCtrl;

  @override
  void initState() {
    super.initState();
    tabCtrl = TabController(length: IndexTab.display.length, vsync: this);
  }

  @override
  void dispose() {
    tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This single watch loads pages -> page numbers -> all stats, and keeps the
    // whole graph alive for as long as this sheet is on screen.
    final ready = ref.watch(indexStatsListsProvider);

    return Column(
      children: [
        TabBar(
          controller: tabCtrl,
          isScrollable: true,
          tabAlignment: .start,
          padding: const .symmetric(horizontal: 12),
          tabs: IndexTab.display
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
          child: ready.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) =>
                Center(child: Text("Couldn't load the index.\n$e")),
            data: (_) => TabBarView(
              controller: tabCtrl,
              children: IndexTab.display
                  .map(
                    (tab) => tab == .pages
                        ? const PagesTabView()
                        : IndexTabView(tab: tab),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
