import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/widgets/overlay/animated_backdrop_filter.dart';

extension ContextOverlayExtension on BuildContext {
  OverlayEntry insertAnimatedOverlay({
    required VoidCallback onTapOutside,
    required List<Widget> children,
    bool backdropOn = false,
    bool modalBarrierOn = false,
    AnimationController? animController,
  }) {
    final OverlayEntry entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            if (backdropOn) AnimatedBackdropFilter(controller: animController),

            ModalBarrier(dismissible: true, onDismiss: onTapOutside),

            ...children,
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
