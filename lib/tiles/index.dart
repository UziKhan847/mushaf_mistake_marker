import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/index/helpers.dart';
import 'package:mushaf_mistake_marker/providers/index/page_numbers.dart';
import 'package:mushaf_mistake_marker/providers/index/stats.dart';
import 'package:mushaf_mistake_marker/widgets/index/index_labels.dart';
import 'package:mushaf_mistake_marker/widgets/index/mini_stat_row.dart';
import 'package:mushaf_mistake_marker/widgets/index/stats_panel.dart';

class IndexTile extends ConsumerStatefulWidget {
  const IndexTile({
    super.key,
    required this.tab,
    required this.index,
    required this.onNavigate,
    this.title, // overrides the derived title (used by the Pages tab)
    this.subtitle, // overrides the derived sub-line (used by the Pages tab)
  });

  final IndexTab tab;
  final int index;
  final VoidCallback onNavigate;
  final String? title;
  final String? subtitle;

  @override
  ConsumerState<IndexTile> createState() => _IndexTileState();
}

class _IndexTileState extends ConsumerState<IndexTile>
    with SingleTickerProviderStateMixin {
  var expanded = false;
  late final AnimationController animCtrl;
  late final Animation<double> rotate, expand;

  @override
  void initState() {
    super.initState();
    animCtrl = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    rotate = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: animCtrl, curve: Curves.easeInOut));
    expand = CurvedAnimation(parent: animCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  void toggle() {
    setState(() => expanded = !expanded);
    expanded ? animCtrl.forward() : animCtrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final label = indexLabel(widget.tab, widget.index);

    final showStats = widget.tab != .sajdah;
    final stats = showStats
        ? statsFromMap(ref.watch(statsProvider(widget.tab))[widget.index])
        : null;

    final pageNum = ref
        .watch(pagesNumberProvider)
        .value?[widget.tab]?[widget.index];

    final title = widget.title ?? label.title;
    final subLine =
        widget.subtitle ?? (pageNum != null ? 'Page $pageNum' : label.subtitle);

    final tinted = label.isHizbStart;

    return Column(
      mainAxisSize: .min,
      children: [
        Material(
          color: tinted ? cs.surfaceContainerHighest : null,
          child: InkWell(
            onTap: widget.onNavigate,
            child: Padding(
              padding: const .fromLTRB(12, 10, 8, 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 52,
                    child: Text(
                      label.big,
                      textAlign: .center,
                      style: tt.headlineMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: .w300,
                        height: 1,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          title,
                          style: tt.bodyLarge?.copyWith(fontWeight: .w600),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            if (subLine != null) ...[
                              Flexible(
                                child: Text(
                                  subLine,
                                  overflow: .ellipsis,
                                  style: tt.bodySmall?.copyWith(
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            if (stats != null) MiniStatRow(stats: stats),
                          ],
                        ),
                      ],
                    ),
                  ),

                  if (showStats)
                    RotationTransition(
                      turns: rotate,
                      child: IconButton(
                        visualDensity: .compact,
                        icon: const Icon(Icons.expand_more_rounded),
                        color: cs.onSurfaceVariant,
                        onPressed: toggle,
                        tooltip: 'Details',
                      ),
                    )
                  else
                    Padding(
                      padding: const .only(right: 8),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (stats != null)
          SizeTransition(
            sizeFactor: expand,
            child: StatsPanel(stats: stats, cs: cs, tt: tt),
          ),
      ],
    );
  }
}
