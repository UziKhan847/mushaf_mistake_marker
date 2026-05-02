import 'package:flutter/material.dart';

class StatsVDivider extends StatelessWidget {
  const StatsVDivider({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
    height: 60,
    child: VerticalDivider(width: 1, color: Colors.black12),
  );
}
