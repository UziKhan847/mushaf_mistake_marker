import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageHeaderOverlay extends ConsumerWidget {
  const PageHeaderOverlay({
    super.key,
    required this.link,
    required this.widgetKey,
    required this.itemCount,
    required this.itemBuilder,
    this.elevation = 4.0,
    this.verticalOffset = 8.0,
    this.borderRadius,
  });

  final LayerLink link;
  final GlobalKey widgetKey;
  final double verticalOffset;
  final double elevation;
  final int itemCount;
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
    final (btnW, btnH) = (renderBox.size.width, renderBox.size.height);
    final buttonBottom = renderBox.localToGlobal(Offset.zero).dy + btnH;

    final mediaQ = MediaQuery.of(context);

    final (scrH, bottomInset, bottomPadding) = (
      mediaQ.size.height,
      mediaQ.viewInsets.bottom,
      mediaQ.padding.bottom,
    );

    final availableHeight =
        scrH -
        buttonBottom -
        verticalOffset -
        bottomInset -
        bottomPadding -
        8.0;

    return CompositedTransformFollower(
      link: link,
      showWhenUnlinked: false,
      offset: Offset(0, btnH + verticalOffset),
      child: Material(
        elevation: elevation,
        borderRadius: borderRadius ?? .circular(4),
        color: Theme.of(context).colorScheme.surface,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: btnW,
            maxHeight: availableHeight,
            minHeight: 200,
          ),
          child: ListView.builder(
            padding: .zero,
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          ),
        ),
      ),
    );
  }
}
