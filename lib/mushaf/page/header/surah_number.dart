import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/mushaf/variables.dart';
import 'package:mushaf_mistake_marker/mushaf/page/page_changed_handler.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/page_header_overlay.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller.dart';
import 'package:mushaf_mistake_marker/surah/surah.dart';

class SurahNumberHeader extends ConsumerStatefulWidget {
  const SurahNumberHeader({super.key, required this.surah});

  final Surah surah;

  @override
  ConsumerState<SurahNumberHeader> createState() => _SurahNumberHeaderState();
}

class _SurahNumberHeaderState extends ConsumerState<SurahNumberHeader> {
  final link = LayerLink();

  final widgetKey = GlobalKey();

  OverlayEntry? overlay;

  @override
  Widget build(BuildContext context) {
    final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider);
    final onPgChgHandler = PageChangedHandler(ref: ref);

    final surahInfo =
        '${widget.surah.number} ${widget.surah.name} (${widget.surah.numOfVs})';

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
                itemCount: 114,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: .opaque,
                    onTap: () {
                      final surahPg = surahStartPage[index + 1]!;

                      context.removeOverlayEntry(overlay);
                      mushafPgCtrlProv.jumpToPage(surahPg - 1);
                      onPgChgHandler.onJumpToPage(surahPg - 1);
                    },
                    child: Padding(
                      padding: const .only(top: 20, bottom: 20),
                      child: Center(
                        child: Text('${index + 1} - ${widget.surah.name}'),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
        child: Text(
          surahInfo,
          style: TextStyle(decoration: .underline, decorationStyle: .dashed),
        ),
      ),
    );
  }
}
