import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  const IconLabel({
    super.key,
    required this.labelText,
    required this.textColor,
    this.size = 10.0,
  });

  final String labelText;
  final double size;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      style: TextStyle(fontSize: size, color: textColor),
    );
  }
}
