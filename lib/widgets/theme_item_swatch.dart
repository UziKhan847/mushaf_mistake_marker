import 'package:flutter/material.dart';

class ThemeItemSwatch extends StatelessWidget {
  const ThemeItemSwatch({
    super.key,
    required this.color,
    this.borderColor,
    this.size = const Size(18, 18),
    this.borderWidth = 1.5,
    this.borderRadius = 4.0,
  });

  final Color color;
  final Color? borderColor;
  final Size size;
  final double borderWidth;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: borderWidth,
              color: borderColor ?? cs.primary,
            ),
            color: color,
          ),
        ),
      ),
    );
  }
}
