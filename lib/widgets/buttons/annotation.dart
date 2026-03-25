import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/constants.dart';

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
  final int color;
  final VoidCallback onTap;
  final bool isSelected;
  final int selectedColor;
  final Color selectedTextColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: annotateBtnWidth,
        height: 32,
        color: Color(isSelected ? selectedColor : color),
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
