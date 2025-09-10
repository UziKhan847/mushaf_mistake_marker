import 'package:flutter/material.dart';

extension ContextOverlayExtension on BuildContext {
  OverlayEntry insertOverlay({
    required VoidCallback onTapOutside,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    required LayerLink layerLink,
    required GlobalKey widgetKey,
    double verticalOffset = 8.0,
    double elevation = 4.0,
    BorderRadius? borderRadius,
  }) {
    final renderObject = widgetKey.currentContext?.findRenderObject();
    if (renderObject == null || renderObject is! RenderBox) {
      throw Exception(
        'widgetKey is not mounted or does not point to a RenderBox.',
      );
    }

    final renderBox = renderObject;
    final (height, width) = (renderBox.size.height, renderBox.size.width);
    final screenHeight = MediaQuery.of(this).size.height;
    final bottomInset = MediaQuery.of(this).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(this).padding.bottom;
    final buttonBottom = renderBox.localToGlobal(Offset.zero).dy + height;

    final availableHeight =
        screenHeight -
        buttonBottom -
        verticalOffset -
        bottomInset -
        bottomPadding -
        8.0;

    final OverlayEntry entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            ModalBarrier(
              dismissible: true,
              color: Colors.transparent,
              onDismiss: onTapOutside,
            ),

            CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, height + verticalOffset),
              child: Material(
                elevation: elevation,
                borderRadius: borderRadius ?? BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.surface,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: width,
                    maxHeight: availableHeight > 40 ? availableHeight : 200,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: itemCount,
                    itemBuilder: itemBuilder,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(this).insert(entry);
    return entry;
  }

  void removeOverlayEntry(OverlayEntry? entry) {
    if (entry != null && entry.mounted) {
      entry.remove();
      entry.dispose();
    }
  }
}
