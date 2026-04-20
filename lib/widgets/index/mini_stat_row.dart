import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/models/index/stats.dart';
import 'package:mushaf_mistake_marker/widgets/index/chip.dart';

class MiniStatRow extends StatelessWidget {
  const MiniStatRow({super.key, required this.stats});
  final IndexStats stats;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      StatChip(color: Colors.red, n: stats.mistakes),
      StatChip(color: Colors.lightBlue, n: stats.oldMistakes),
      StatChip(color: Colors.purple, n: stats.doubts),
      StatChip(color: Colors.green, n: stats.tajwidMistakes),
    ],
  );
}
