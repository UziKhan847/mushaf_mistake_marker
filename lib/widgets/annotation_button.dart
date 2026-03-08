import 'package:flutter/material.dart';

class AnnotationButton extends StatelessWidget {
  const AnnotationButton({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
    required this.isSelected,
    required this.isSelectedColor,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isSelected;
  final Color isSelectedColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 32,
        color: isSelected ? isSelectedColor : color,
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
