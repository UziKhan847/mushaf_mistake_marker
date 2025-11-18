import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSideSheetOverlay extends ConsumerWidget {
  const BottomSideSheetOverlay({
    super.key,
    this.elevation = 4.0,
    this.borderRadius,
    required this.itemCount,
    required this.itemBuilder,
  });

  final double elevation;
  final BorderRadiusGeometry? borderRadius;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  double getTop(Size scrSize) => (scrSize.height - (scrSize.height - 50)) / 2;

  BorderRadiusGeometry getBorderRadius(bool isPortrait, Radius radius) =>
      isPortrait
      ? BorderRadius.only(topLeft: radius, topRight: radius)
      : BorderRadius.only(topLeft: radius, bottomLeft: radius);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = Radius.circular(20);
    final mediaQ = MediaQuery.of(context);

    final scrSize = mediaQ.size;
    final isPortrait = mediaQ.orientation == Orientation.portrait;

    return Positioned(
      right: isPortrait ? null : 0,
      bottom: isPortrait ? 0 : null,
      top: isPortrait ? null : getTop(scrSize),
      child: Material(
        clipBehavior: Clip.hardEdge,
        elevation: elevation,
        borderRadius: borderRadius ?? getBorderRadius(isPortrait, radius),
        color: Theme.of(context).colorScheme.surface,
        child: SizedBox(
          width: isPortrait ? scrSize.width : scrSize.height,
          height: isPortrait ? (scrSize.height - 50) / 2 : scrSize.height - 50,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          ),
        ),
      ),
    );
  }
}
