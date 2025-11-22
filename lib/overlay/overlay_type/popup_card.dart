import 'package:flutter/material.dart';

class PopupCard extends StatelessWidget {
  const PopupCard({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
     final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Material(
        color: colorScheme.surface,
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(14),
        ),
        child: Padding(
          padding: const .all(16.0),
          child: child,
        ),
      ),
    );
  }
}
