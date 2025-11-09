import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/overlay_position_type/dynamic_overlay.dart';
import 'package:mushaf_mistake_marker/overlay_position_type/static_overlay.dart';

extension ContextOverlayExtension on BuildContext {
  OverlayEntry insertOverlay({
    required VoidCallback onTapOutside,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    LayerLink? layerLink,
    GlobalKey? widgetKey,
    bool isStatic = false,
    double verticalOffset = 8.0,
    double elevation = 4.0,
    BorderRadius? borderRadius,
  }) {
    if (isStatic == false) {
      if (layerLink == null && widgetKey == null) {
        throw Exception(
          'Error: If isStatic == false, then layerLink and widgetKey cannot be null!',
        );
      }
    }

    final OverlayEntry entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(color: Colors.black.withAlpha(40)),
            ),

            ModalBarrier(
              dismissible: true,
              color: Colors.transparent,
              onDismiss: onTapOutside,
            ),

            if (isStatic)
              StaticOverlay(
                elevation: elevation,
                borderRadius: borderRadius,
                itemCount: itemCount,
                itemBuilder: itemBuilder,
              ),

            if (!isStatic)
              DynamicOverlay(
                link: layerLink!,
                widgetKey: widgetKey!,
                verticalOffset: verticalOffset,
                elevation: elevation,
                borderRadius: borderRadius,
                itemCount: itemCount,
                itemBuilder: itemBuilder,
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
