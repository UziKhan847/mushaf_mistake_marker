import 'package:flutter/material.dart';

class AnnotationButton extends StatelessWidget {
  const AnnotationButton({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
    required this.isSelected,
    required this.selectedColor,
    required this.selectedTextColor,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isSelected;
  final Color selectedColor;
  final Color selectedTextColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 32,
        color: isSelected ? selectedColor : color,
        alignment: .center,
        child: FittedBox(
          fit: .scaleDown,
          child: Padding(
            padding: const .symmetric(horizontal: 10),
            child: Text(
              label,
              textAlign: .center,
              style: TextStyle(
                fontWeight: isSelected ? .w700 : .w500,
                color: isSelected ? selectedTextColor : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
