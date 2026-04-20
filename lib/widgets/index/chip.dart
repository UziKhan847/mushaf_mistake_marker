import 'package:flutter/material.dart';

class StatChip extends StatelessWidget {
  const StatChip({super.key, required this.color, required this.n});

  final Color color;
  final int n;

  @override
  Widget build(BuildContext context) {
    return n == 0
        ? const SizedBox.shrink()
        : Container(
            margin: const .only(left: 4),
            padding: const .symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withAlpha(38),
              borderRadius: .circular(20),
            ),
            child: Text(
              '$n',
              style: TextStyle(fontSize: 11, fontWeight: .w700, color: color),
            ),
          );
  }
}
