import 'package:flutter/material.dart';

class StatCell extends StatelessWidget {
  const StatCell({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Expanded(
      child: Padding(
        padding: const .symmetric(vertical: 12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 4),
            Text(
              '$value',
              style: tt.titleMedium?.copyWith(
                fontWeight: .w700,
                color: cs.onSurface,
              ),
            ),
            Text(
              label,
              style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }
}
