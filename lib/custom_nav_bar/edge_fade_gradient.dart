import 'package:flutter/material.dart';

class EdgeFadeGradient extends StatelessWidget {
  const EdgeFadeGradient({
    super.key,
    required this.isPortrait,
    required this.isStart,
    required this.bgColor,
    this.offset = 0,
  });

  final bool isPortrait;
  final bool isStart;
  final Color bgColor;
  final double offset;

  Alignment beginAlignment() {
    if (isPortrait) return isStart ? .centerLeft : .centerRight;
    return isStart ? .topCenter : .bottomCenter;
  }

  Alignment endAlignment() {
    if (isPortrait) return isStart ? .centerRight : .centerLeft;
    return isStart ? .bottomCenter : .topCenter;
  }

  @override
  Widget build(BuildContext context) {
    final (left, right, top, bottom) = (
      isPortrait ? (isStart ? offset : null) : 0.0,
      isPortrait ? (isStart ? null : offset) : 0.0,
      isPortrait ? 0.0 : (isStart ? offset : null),
      isPortrait ? 0.0 : (isStart ? null : offset),
    );

    final colors = [
      bgColor,
      bgColor.withAlpha(212),
      bgColor.withAlpha(170),
      bgColor.withAlpha(128),
      bgColor.withAlpha(85),
      bgColor.withAlpha(42),
      bgColor.withAlpha(0),
    ];

    const stops = [0.0, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 1.0];

    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      width: isPortrait ? 20.0 : null,
      height: isPortrait ? null : 20.0,
      child: IgnorePointer(
        ignoring: true,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: beginAlignment(),
              end: endAlignment(),
              colors: colors,
              stops: stops,
            ),
          ),
        ),
      ),
    );
  }
}
