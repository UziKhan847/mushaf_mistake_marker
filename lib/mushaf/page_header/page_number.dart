import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/mushaf/page_changed_handler.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/page_header_overlay.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';

class PageNumber extends ConsumerStatefulWidget {
  const PageNumber({super.key, required this.pageNumber});

  final int pageNumber;

  @override
  ConsumerState<PageNumber> createState() => _PageNumberState();
}

class _PageNumberState extends ConsumerState<PageNumber> {
  final link = LayerLink();

  final widgetKey = GlobalKey();

  OverlayEntry? overlay;

  @override
  Widget build(BuildContext context) {
    final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider);
    final onPgChgHandler = PageChangedHandler(ref: ref);

    return CompositedTransformTarget(
      link: link,
      child: TextButton(
        key: widgetKey,
        onPressed: () {
          overlay = context.insertOverlay(
            onTapOutside: () {
              context.removeOverlayEntry(overlay);
            },
            children: [
              PageHeaderOverlay(
                link: link,
                widgetKey: widgetKey,
                itemCount: 604,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      context.removeOverlayEntry(overlay);
                      mushafPgCtrlProv.jumpToPage(index);
                      onPgChgHandler.onJumpToPage(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Center(child: Text('${index + 1}')),
                    ),
                  );
                },
              ),
            ],
          );
        },
        child: Text(
          '${widget.pageNumber}',
          style: TextStyle(
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dashed,
          ),
        ),
      ),
    );
  }
}
