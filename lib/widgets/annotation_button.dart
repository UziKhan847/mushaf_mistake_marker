import 'package:flutter/material.dart';

class AnnotationButton extends StatelessWidget {
  const AnnotationButton({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
    required this.isSelected,
    required this.selectedColor,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isSelected;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 32,
        color: isSelected ? selectedColor : color,
        alignment: Alignment.center,
        child: FittedBox(
          fit: .scaleDown,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              label,
              textAlign: .center,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
