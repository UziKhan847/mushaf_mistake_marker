import 'package:flutter/material.dart';

class NavBarItemOverlay extends StatelessWidget {
  const NavBarItemOverlay({
    super.key,
    required this.widgetKey,
    required this.navBarSize,
    required this.itemCount,
    required this.itemBuilder,
    this.elevation = 4.0,
  });

  final GlobalKey widgetKey;
  final Size navBarSize;
  final double elevation;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  double clamp(double preferred, double size, double screenSize) {
    final upper = screenSize - size - 5.0;
    if (upper < 5.0) return 0.0;
    return preferred.clamp(5.0, upper);
  }

  @override
  Widget build(BuildContext context) {
    final renderObject = widgetKey.currentContext?.findRenderObject();
    if (renderObject is! RenderBox) return const SizedBox.shrink();

    final isPortrait = MediaQuery.orientationOf(context) == .portrait;
    final screenSize = MediaQuery.sizeOf(context);
    final btnOffset = renderObject.localToGlobal(.zero);
    final btnW = renderObject.size.width;
    final screenAxis = isPortrait ? screenSize.width : screenSize.height;

    var max = btnW * itemCount.clamp(1, 5);
    var offset = clamp(
      (isPortrait ? btnOffset.dx : btnOffset.dy) - ((max - btnW) / 2),
      max,
      screenAxis,
    );

    if (max > screenAxis) {
      max = btnW;
      offset = isPortrait ? btnOffset.dx : btnOffset.dy;
    }

    return Positioned(
      left: isPortrait ? offset : null,
      right: isPortrait ? null : navBarSize.width + 5,
      top: isPortrait ? null : offset,
      bottom: isPortrait ? navBarSize.height + 5 : null,
      child: Material(
        elevation: elevation,
        clipBehavior: .hardEdge,
        borderRadius: .circular(8.0),
        color: Theme.of(context).colorScheme.surface,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isPortrait ? max : btnW,
            maxHeight: isPortrait ? btnW : max,
            minHeight: isPortrait ? btnW : 0.0,
            minWidth: isPortrait ? 0.0 : btnW,
          ),
          child: ListView.builder(
            scrollDirection: isPortrait ? .horizontal : .vertical,
            padding: .zero,
            itemCount: itemCount,
            itemExtent: btnW,
            itemBuilder: itemBuilder,
          ),
        ),
      ),
    );
  }
}
