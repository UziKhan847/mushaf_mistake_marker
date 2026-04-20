import 'package:flutter/material.dart';

class BottomSideSheetDragHandle extends StatelessWidget {
  const BottomSideSheetDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isPortrait = MediaQuery.orientationOf(context) == .portrait;

    return Container(
      width: isPortrait ? .infinity : 28,
      height: isPortrait ? 28 : .infinity,
      color: isPortrait ? null : cs.primaryContainer.withAlpha(40),
      child: Center(
        child: Container(
          width: isPortrait ? 36 : 4,
          height: isPortrait ? 4 : 36,
          decoration: BoxDecoration(
            color: cs.onPrimaryContainer,
            borderRadius: .circular(2),
          ),
        ),
      ),
    );
  }
}
