import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/models/index/entry.dart';

class IndexSajdahTile extends StatelessWidget {
  const IndexSajdahTile({
    super.key,
    required this.entry,
    required this.tab,
    required this.index,
    required this.onNavigate,
  });

  final IndexEntry entry;
  final IndexTab tab;
  final int index;
  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: .min,
      children: [
        InkWell(
          onTap: onNavigate,
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
                    '${entry.page}',
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
                        entry.title,
                        style: tt.bodyLarge?.copyWith(fontWeight: .w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        entry.subtitle,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
