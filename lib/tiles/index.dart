import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/models/stats.dart';
import 'package:mushaf_mistake_marker/widgets/index/mini_stat_row.dart';
import 'package:mushaf_mistake_marker/widgets/index/stats_panel.dart';

class IndexTile extends ConsumerStatefulWidget {
  const IndexTile({
    super.key,
    required this.entry,
    required this.tab,
    required this.index,
    required this.onNavigate,
  });

  final Map<String, Object?> entry;
  final IndexTab tab;
  final int index;
  final VoidCallback onNavigate;

  @override
  ConsumerState<IndexTile> createState() => _IndexTileState();
}

class _IndexTileState
    extends
        ConsumerState<IndexTile> //TODO: fix
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

    if (expanded) {
      animCtrl.forward();
    } else {
      animCtrl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final entry = widget.entry;

    return Column(
      mainAxisSize: .min,
      children: [
        InkWell(
          onTap: widget.onNavigate,
          child: Padding(
            padding: const .fromLTRB(16, 10, 8, 10),
            child: Row(
              children: [
                // Page badge
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: .circular(12),
                  ),
                  alignment: .center,
                  child: Text(
                    '${entry['pNum'] as int}',
                    style: tt.labelLarge?.copyWith(
                      color: cs.onPrimaryContainer,
                      fontWeight: .w700,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        entry['title'] as String,
                        style: tt.bodyLarge?.copyWith(fontWeight: .w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        entry['subtitle'] as String,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                // Mini Stats Row on the Tile without Expanding
                MiniStatRow(stats: const IndexStats()),

                RotationTransition(
                  turns: rotate,
                  child: IconButton(
                    visualDensity: .compact,
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

        // Expanded Stats
        SizeTransition(
          sizeFactor: expand,
          child: StatsPanel(stats: const IndexStats(), cs: cs, tt: tt),
        ),
      ],
    );
  }
}
