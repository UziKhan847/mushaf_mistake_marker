import 'package:flutter/material.dart';

class StaticOverlay extends StatelessWidget {
  const StaticOverlay({
    super.key,
    required this.elevation,
    required this.borderRadius,
    required this.itemCount,
    required this.itemBuilder,
  });

  final double elevation;
  final BorderRadiusGeometry? borderRadius;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  (double, double) getOffset(Size scrSize, Size navBarSize, bool isPortrait) {
    if (isPortrait) {
      final contW = scrSize.width - 15;

      final left = (scrSize.width - contW) / 2;
      final bottom = navBarSize.height;

      return (left, bottom);
    }

    final contH = scrSize.height - 15;

    final top = (scrSize.height - contH) / 2;
    final right = navBarSize.width;

    return (right, top);
  }

  BorderRadiusGeometry getBorderRadius(bool isPortrait) => isPortrait
      ? BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        )
      : BorderRadius.only(
          topLeft: Radius.circular(4),
          bottomLeft: Radius.circular(4),
        );

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);

    final scrSize = mediaQ.size;
    final isPortrait = mediaQ.orientation == Orientation.portrait;
    const navBarSize = Size(72, 56);

    final centerOffset = getOffset(scrSize, navBarSize, isPortrait);

    final (x, y) = centerOffset;

    return Positioned(
      left: isPortrait ? x : null,
      right: isPortrait ? null : x,
      bottom: isPortrait ? y : null,
      top: isPortrait ? null : y,
      child: Material(
        elevation: elevation,
        borderRadius: borderRadius ?? getBorderRadius(isPortrait),
        color: Theme.of(context).colorScheme.surface,
        child: SizedBox(
          width: isPortrait ? scrSize.width - 15 : scrSize.width / 2,
          height: isPortrait ? scrSize.height / 2 : scrSize.height - 15,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            //shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          ),
        ),
      ),
    );
  }
}
