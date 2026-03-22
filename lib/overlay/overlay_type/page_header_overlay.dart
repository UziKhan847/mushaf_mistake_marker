import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageHeaderOverlay extends ConsumerStatefulWidget {
  const PageHeaderOverlay({
    super.key,
    required this.widgetKey,
    required this.itemCount,
    required this.itemBuilder,
    required this.initialIndex,
    this.itemHeight = 40,
    this.elevation = 4.0,
    this.verticalOffset = 8.0,
    this.borderRadius,
  });

  final GlobalKey widgetKey;
  final double verticalOffset;
  final double elevation;
  final int itemCount;
  final int initialIndex;
  final double itemHeight;
  final IndexedWidgetBuilder itemBuilder;
  final BorderRadius? borderRadius;

  @override
  ConsumerState<PageHeaderOverlay> createState() => PageHeaderOverlayState();
}

class PageHeaderOverlayState extends ConsumerState<PageHeaderOverlay> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      initialScrollOffset: widget.initialIndex * widget.itemHeight,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final renderObject = widget.widgetKey.currentContext?.findRenderObject();
    if (renderObject is! RenderBox) return const SizedBox.shrink();

    final btnW = renderObject.size.width;
    final globalOffset = renderObject.localToGlobal(Offset.zero);
    final left = globalOffset.dx;
    final top =
        globalOffset.dy + renderObject.size.height + widget.verticalOffset;
    final scrH = MediaQuery.sizeOf(context).height;
    final availableHeight = scrH - top - 20;

    return Positioned(
      left: left,
      top: top,
      child: Material(
        clipBehavior: Clip.hardEdge,
        elevation: widget.elevation,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.surface,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: btnW,
            maxHeight: availableHeight,
            minHeight: widget.itemHeight,
          ),
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.zero,
            itemCount: widget.itemCount,
            itemExtent: widget.itemHeight,
            itemBuilder: widget.itemBuilder,
          ),
        ),
      ),
    );
  }
}
