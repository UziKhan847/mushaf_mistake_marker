import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavBarItemOverlay extends ConsumerWidget {
  const NavBarItemOverlay({
    super.key,
    required this.widgetKey,
    required this.navBarSize,
    required this.itemCount,
    required this.itemBuilder,
    this.itemHeight = 40,
    this.elevation = 4.0,
  });

  final GlobalKey widgetKey;
  final Size navBarSize;
  final double elevation;
  final int itemCount;
  final double itemHeight;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final renderObject = widgetKey.currentContext?.findRenderObject();
    if (renderObject is! RenderBox) return const SizedBox.shrink();

    final isPortrait = MediaQuery.orientationOf(context) == .portrait;
    final btnGlobalOffset = renderObject.localToGlobal(.zero);
    final max = itemHeight * 5.5;

    return Positioned(
      left: isPortrait ? btnGlobalOffset.dx : navBarSize.height + max,
      top: isPortrait ? navBarSize.height + max : btnGlobalOffset.dy,
      child: Material(
        clipBehavior: .hardEdge,
        borderRadius: BorderRadius.only(
          topLeft: .circular(4.0),
          topRight: isPortrait ? .circular(4.0) : .zero,
          bottomLeft: isPortrait ? .zero : .circular(4.0),
        ),
        color: Theme.of(context).colorScheme.surface,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isPortrait ? .infinity : max,
            maxHeight: isPortrait ? max : .infinity,
            minHeight: isPortrait ? itemHeight : 0.0,
            minWidth: isPortrait ? 0.0 : itemHeight,
          ),
          child: ListView.builder(
            padding: .zero,
            itemCount: itemCount,
            itemExtent: itemHeight,
            itemBuilder: itemBuilder,
          ),
        ),
      ),
    );
  }
}
