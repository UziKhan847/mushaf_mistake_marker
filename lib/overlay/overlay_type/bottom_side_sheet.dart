import 'package:flutter/material.dart';

class BottomSideSheetOverlay extends StatelessWidget {
  const BottomSideSheetOverlay({
    super.key,
    required this.child,
    this.elevation = 4.0,
    this.borderRadius,
  });

  final Widget child;
  final double elevation;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = const Radius.circular(20);
    final scrSize = MediaQuery.sizeOf(context);
    final isPortrait = MediaQuery.orientationOf(context) == Orientation.portrait;

    return Positioned(
      right: isPortrait ? null : 0,
      bottom: isPortrait ? 0 : null,
      top: isPortrait ? null : (scrSize.height - (scrSize.height - 50)) / 2,
      child: Material(
        clipBehavior: Clip.hardEdge,
        elevation: elevation,
        borderRadius:
            borderRadius ??
            BorderRadius.only(
              topLeft: radius,
              topRight: isPortrait ? radius : Radius.zero,
              bottomLeft: isPortrait ? Radius.zero : radius,
            ),
        color: Theme.of(context).colorScheme.surface,
        child: SizedBox(
          width: isPortrait ? scrSize.width : scrSize.height,
          height: isPortrait ? (scrSize.height - 50) / 2 : scrSize.height - 50,
          child: child,
        ),
      ),
    );
  }
}