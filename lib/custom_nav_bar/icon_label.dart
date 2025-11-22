import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  const IconLabel({
    super.key,
    required this.labelText,
    required this.textColor,
    this.fontSize,
  });

  final String labelText;
  final Color textColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      labelText,
      maxLines: 1,
      overflow: .ellipsis,
      style: textTheme.labelSmall?.copyWith(
        color: textColor,
        fontSize: fontSize ?? textTheme.labelSmall?.fontSize,
        fontWeight: .w500,
        letterSpacing: 0.2,
      ),
    );
  }
}
