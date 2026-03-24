import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavBarItemOverlay extends ConsumerWidget {
  const NavBarItemOverlay({
    super.key,
    required this.widgetKey,
    required this.navBarSize,
    required this.itemCount,
    required this.itemBuilder,
    this.itemHeight = 50,
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

    print('MADE IT PASSED!');
    print('RenderBox Size: ${renderObject.size}');
    print('RenderBox Offset Start: ${renderObject.localToGlobal(.zero)}');

    final btnW = renderObject.size.width;
    final isPortrait = MediaQuery.orientationOf(context) == .portrait;
    final btnGlobalOffset = renderObject.localToGlobal(.zero);
    final max = itemHeight * 5.5;

    return Positioned(
      left: isPortrait ? btnGlobalOffset.dx : null,
      right: isPortrait ? null : navBarSize.width,
      top: isPortrait ? null : btnGlobalOffset.dy,
      bottom: isPortrait ? navBarSize.height : null,
      child: Material(
        clipBehavior: .hardEdge,
        borderRadius: .only(
          topLeft: .circular(4.0),
          topRight: isPortrait ? .circular(4.0) : .zero,
          bottomLeft: isPortrait ? .zero : .circular(4.0),
        ),
        color: Theme.of(context).colorScheme.surface,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isPortrait ? btnW : max,
            maxHeight: isPortrait ? max : btnW,
            minHeight: isPortrait ? itemHeight : 0.0,
            minWidth: isPortrait ? 0.0 : itemHeight,
          ),
          child: ListView.builder(
            //shrinkWrap: true,
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
