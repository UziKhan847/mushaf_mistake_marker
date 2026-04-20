import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/models/index/stats.dart';
import 'package:mushaf_mistake_marker/widgets/index/stat_cell.dart';

class StatsPanel extends StatelessWidget {
  const StatsPanel({
    super.key,
    required this.stats,
    required this.cs,
    required this.tt,
  });

  final IndexStats stats;
  final ColorScheme cs;
  final TextTheme tt;

  Widget get vDivider => const SizedBox(
    height: 60,
    child: VerticalDivider(width: 1, color: Colors.black12),
  );

  double quality(IndexStats s) {
    final weighted =
        s.mistakes + (s.oldMistakes * 0.5) + s.doubts + s.tajwidMistakes;
    if (weighted == 0) return 1.0;
    return (1 - (weighted / (weighted + s.revisions + 1))).clamp(0.0, 1.0);
  }

  (String, Color) qualityLabelAndColor(double q) => switch (q) {
    >= 0.9 => ('Excellent', const Color(0xFF2E7D32)),
    >= 0.7 => ('Good', const Color(0xFF558B2F)),
    >= 0.4 => ('Needs work', const Color(0xFFE65100)),
    _ => ('Struggling', const Color(0xFFC62828)),
  };

  @override
  Widget build(BuildContext context) {
    final q = quality(stats);
    final (qLabel, qColor) = qualityLabelAndColor(q);

    return Container(
      margin: const .fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: .circular(16),
      ),
      child: Column(
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              StatCell(
                icon: Icons.close_rounded,
                color: Colors.red,
                label: 'Mistakes',
                value: stats.mistakes,
              ),
              vDivider,
              StatCell(
                icon: Icons.history_rounded,
                color: Colors.lightBlue,
                label: 'Old\nmistakes',
                value: stats.oldMistakes,
              ),
              vDivider,
              StatCell(
                icon: Icons.help_outline_rounded,
                color: Colors.purple,
                label: 'Doubts',
                value: stats.doubts,
              ),
              vDivider,
              StatCell(
                icon: Icons.record_voice_over_outlined,
                color: Colors.green,
                label: 'Tajwīd',
                value: stats.tajwidMistakes,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      'Memorisation quality',
                      style: tt.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      qLabel,
                      style: tt.labelSmall?.copyWith(
                        color: cs.primary,
                        fontWeight: .w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: .circular(8),
                  child: LinearProgressIndicator(
                    value: q,
                    minHeight: 6,
                    backgroundColor: cs.outline.withValues(alpha: 0.2),
                    valueColor: AlwaysStoppedAnimation(qColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
