import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/models/index/entry.dart';
import 'package:mushaf_mistake_marker/widgets/index/mini_stat_row.dart';
import 'package:mushaf_mistake_marker/widgets/index/stats_panel.dart';

class IndexTile extends StatefulWidget {
  const IndexTile({super.key, required this.entry, required this.onNavigate});
 
  final IndexEntry entry;
  final VoidCallback onNavigate;
 
  @override
  State<IndexTile> createState() => _IndexTileState();
}
 
class _IndexTileState extends State<IndexTile> with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _anim;
  late final Animation<double> _rotate;
  late final Animation<double> _expand;
 
  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    _rotate = Tween<double>(begin: 0, end: 0.5)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeInOut));
    _expand = CurvedAnimation(parent: _anim, curve: Curves.easeInOut);
  }
 
  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }
 
  void _toggle() {
    setState(() => _expanded = !_expanded);
    if (_expanded) {
      _anim.forward();
    } else {
      _anim.reverse();
    }
  }
 
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final e = widget.entry;
 
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Main row ──────────────────────────────────────────
        InkWell(
          onTap: widget.onNavigate,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
            child: Row(
              children: [
                // Page badge
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${e.page}',
                    style: tt.labelLarge?.copyWith(
                      color: cs.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
 
                const SizedBox(width: 14),
 
                // Title + subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.title,
                          style: tt.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(e.subtitle,
                          style: tt.bodySmall
                              ?.copyWith(color: cs.onSurfaceVariant)),
                    ],
                  ),
                ),
 
                // Mini stat chips
                MiniStatRow(stats: e.stats),
 
                // Expand chevron
                RotationTransition(
                  turns: _rotate,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.expand_more_rounded),
                    color: cs.onSurfaceVariant,
                    onPressed: _toggle,
                    tooltip: 'Details',
                  ),
                ),
              ],
            ),
          ),
        ),
 
        // ── Expanded stats panel ───────────────────────────────
        SizeTransition(
          sizeFactor: _expand,
          child: StatsPanel(stats: e.stats, cs: cs, tt: tt),
        ),
      ],
    );
  }
}