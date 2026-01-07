import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageHeaderOverlay extends ConsumerWidget {
  const PageHeaderOverlay({
    super.key,
    required this.link,
    required this.widgetKey,
    required this.itemCount,
    required this.itemBuilder,
    required this.initialIndex,
    this.itemHeight = 40,
    this.elevation = 4.0,
    this.verticalOffset = 8.0,
    this.borderRadius,
  });

  final LayerLink link;
  final GlobalKey widgetKey;
  final double verticalOffset;
  final double elevation;
  final int itemCount;
  final int initialIndex;
  final double itemHeight;
  final IndexedWidgetBuilder itemBuilder;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final renderObject = widgetKey.currentContext?.findRenderObject();
    if (renderObject == null || renderObject is! RenderBox) {
      throw Exception(
        'WidgetKey is not mounted or does not point to a RenderBox.',
      );
    }

    final renderBox = renderObject;
    final btnW = renderBox.size.width;
    final buttonOffset = renderBox.localToGlobal(Offset.zero).dy;
    final scrH = MediaQuery.of(context).size.height;

    final availableHeight = scrH - buttonOffset - 20;

    return CompositedTransformFollower(
      link: link,
      showWhenUnlinked: false,
      //offset: Offset(0, 0),
      child: Material(
        clipBehavior: .hardEdge,
        elevation: elevation,
        borderRadius: borderRadius ?? .circular(4),
        color: Theme.of(context).colorScheme.surface,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: btnW,
            maxHeight: availableHeight,
            minHeight: itemHeight,
          ),
          child: ListView.builder(
            controller: ScrollController(
              initialScrollOffset: initialIndex * itemHeight,
            ),
            padding: .zero,
            shrinkWrap: true,
            itemCount: itemCount,
            itemExtent: itemHeight,
            itemBuilder: itemBuilder,
          ),
        ),
      ),
    );
  }
}
