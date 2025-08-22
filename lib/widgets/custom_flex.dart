import 'package:flutter/material.dart';

class CustomFlex extends StatelessWidget {
  const CustomFlex({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.isReversed = false,
    super.key,
  });

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isReversed;

  Axis getAxis(bool isReversed, Orientation orientation) {
    if (isReversed) {
      return orientation == Orientation.landscape
          ? Axis.vertical
          : Axis.horizontal;
    }

    return orientation == Orientation.portrait
        ? Axis.vertical
        : Axis.horizontal;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, orientation) {
        return Flex(
          direction: getAxis(isReversed, orientation),
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        );
      },
    );
  }
}
