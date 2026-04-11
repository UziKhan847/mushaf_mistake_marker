import 'package:flutter/material.dart';

class BottomSideSheetOverlay extends StatelessWidget {
  const BottomSideSheetOverlay({
    super.key,
    required this.child,
    this.elevation = 4.0,
    this.borderRadius,
    this.isFullScreen = false,
  });

  final Widget child;
  final double elevation;
  final BorderRadiusGeometry? borderRadius;
  final bool isFullScreen;

  Size getOverlaySize(bool isPortrait, Size scrSize) {
    if (isFullScreen) {
      return isPortrait
          ? Size(scrSize.width, scrSize.height - 50)
          : Size(scrSize.width - 50, scrSize.height - 25);
    }

    return isPortrait
        ? Size(scrSize.width, (scrSize.height - 50) / 2)
        : Size((scrSize.width - 50) / 2, scrSize.height - 25);
  }

  @override
  Widget build(BuildContext context) {
    final radius = const Radius.circular(20);
    final scrSize = MediaQuery.sizeOf(context);
    final isPortrait = MediaQuery.orientationOf(context) == .portrait;
    final overlaySize = getOverlaySize(isPortrait, scrSize);

    return Positioned(
      right: isPortrait ? null : 0,
      bottom: isPortrait ? 0 : null,
      top: isPortrait ? null : (scrSize.height - (scrSize.height - 25)) / 2,
      child: Material(
        clipBehavior: .hardEdge,
        elevation: elevation,
        borderRadius:
            borderRadius ??
            .only(
              topLeft: radius,
              topRight: isPortrait ? radius : .zero,
              bottomLeft: isPortrait ? .zero : radius,
            ),
        color: Theme.of(context).colorScheme.surface,
        child: SizedBox(
          width: overlaySize.width,
          height: overlaySize.height,
          child: child,
        ),
      ),
    );
  }
}
