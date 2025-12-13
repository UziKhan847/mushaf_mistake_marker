import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/mushaf/page/page_changed_handler.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/page_header_overlay.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller.dart';

class PageNumberHeader extends ConsumerStatefulWidget {
  const PageNumberHeader({super.key, required this.pageNumber});

  final int pageNumber;

  @override
  ConsumerState<PageNumberHeader> createState() => _PageNumberHeaderState();
}

class _PageNumberHeaderState extends ConsumerState<PageNumberHeader> {
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
                    behavior: .opaque,
                    onTap: () {
                      context.removeOverlayEntry(overlay);
                      mushafPgCtrlProv.jumpToPage(index);
                      onPgChgHandler.onJumpToPage(index);
                    },
                    child: Padding(
                      padding: const .only(top: 20, bottom: 20),
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
          style: TextStyle(decoration: .underline, decorationStyle: .dashed),
        ),
      ),
    );
  }
}