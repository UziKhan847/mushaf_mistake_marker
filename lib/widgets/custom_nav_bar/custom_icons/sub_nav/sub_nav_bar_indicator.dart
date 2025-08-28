import 'package:flutter/material.dart';

class SubNavBarIndicator extends StatelessWidget {
  const SubNavBarIndicator({
    super.key,
    required this.isOn,
    required this.iconSize,
    this.indicatorOnColor,
    this.indicatorOffColor,
    this.indicatorSize,
  });

  final bool isOn;
  final double iconSize;
  final Color? indicatorOnColor;
  final Color? indicatorOffColor;
  final double? indicatorSize;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onColor = indicatorOnColor ?? const Color(0xFF4CAF50);
    final offColor =
        indicatorOffColor ??
        (isDark ? Colors.grey.shade700 : Colors.grey.shade300);

    final dotSize = indicatorSize ?? (iconSize * 0.36);

    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: isOn ? onColor : offColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
