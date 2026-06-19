import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
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
  });

  final IndexTab tab;
  final int index;
  final VoidCallback onNavigate;

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
    final stats = statsFromMap(
      ref.watch(statsProvider(widget.tab))[widget.index],
    );

    // Jump-target page number for this row (pages tab handled separately).
    final pageNum = ref
        .watch(pagesNumberProvider)
        .value?[widget.tab]?[widget.index];

    // Tint Ḥizb-boundary rows in the Rubʿ tab.
    final tinted = label.isHizbStart;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: tinted ? cs.primaryContainer.withValues(alpha: 0.25) : null,
          child: InkWell(
            onTap: widget.onNavigate,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
              child: Row(
                children: [
                  // Big category number on the LEFT.
                  SizedBox(
                    width: 52,
                    child: Text(
                      label.big,
                      textAlign: TextAlign.center,
                      style: tt.headlineMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w300,
                        height: 1,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label.title,
                          style: tt.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            if (pageNum != null) ...[
                              Text(
                                'Page $pageNum',
                                style: tt.bodySmall?.copyWith(
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ] else if (label.subtitle != null) ...[
                              Flexible(
                                child: Text(
                                  label.subtitle!,
                                  overflow: TextOverflow.ellipsis,
                                  style: tt.bodySmall?.copyWith(
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            MiniStatRow(stats: stats),
                          ],
                        ),
                      ],
                    ),
                  ),

                  RotationTransition(
                    turns: rotate,
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.expand_more_rounded),
                      color: cs.onSurfaceVariant,
                      onPressed: toggle,
                      tooltip: 'Details',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: expand,
          child: StatsPanel(stats: stats, cs: cs, tt: tt),
        ),
      ],
    );
  }
}
