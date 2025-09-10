import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';

class PageNumber extends StatelessWidget {
  PageNumber({super.key, required this.pageNumber});

  final int pageNumber;
  final link = LayerLink();
  final widgetKey = GlobalKey();
  OverlayEntry? overlay;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: link,
      child: TextButton(
        key: widgetKey,
        onPressed: () {
          overlay = context.insertOverlay(
            onTapOutside: () {
              context.removeOverlayEntry(overlay);
            },
            itemCount: 604,
            itemBuilder: (context, index) {
              return Text('${index + 1}');
            },
            layerLink: link,
            widgetKey: widgetKey,
          );
        },
        child: Text(
          '$pageNumber',
          style: TextStyle(
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dashed,
          ),
        ),
      ),
    );
  }
}
