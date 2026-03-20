import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/mushaf/page/header/variables.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/page_header_overlay.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/page_controller.dart';
import 'package:mushaf_mistake_marker/providers/page_mode.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/juz.dart';

class JuzNumberHeader extends ConsumerStatefulWidget {
  const JuzNumberHeader({
    super.key,
    required this.currentPgIndex,
    this.pageSide = .none,
  });

  final int currentPgIndex;
  final PageSide pageSide;
  static const itemHeight = 50.0;

  @override
  ConsumerState<JuzNumberHeader> createState() => _JuzNumberHeaderState();
}

class _JuzNumberHeaderState extends ConsumerState<JuzNumberHeader> {
  final LayerLink link = LayerLink();
  final GlobalKey widgetKey = GlobalKey();

  bool isOnJuzStartPage(int currentPg, int clickedIndex, Set<int> juzNums) {
    final clickedJuzNum = juzNums.firstWhere(
      (e) => e == clickedIndex + 1,
      orElse: () => 0,
    );

    if (clickedJuzNum == 0) return false;

    final juzStrtPg = juzStartPage[clickedJuzNum];

    return juzStrtPg == currentPg;
  }

  @override
  Widget build(BuildContext context) {
    final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider.notifier);
    final dualPageMode = ref.watch(pageModeProvider);
    final juzNums = ref.watch(juzProvider(widget.currentPgIndex));

    if (juzNums == null || juzNums.isEmpty) return const SizedBox.shrink();

    final currentJuzNum = juzNums.last;

    return CompositedTransformTarget(
      link: link,
      child: TextButton(
        key: widgetKey,
        onPressed: () {
          OverlayEntry? overlay;

          overlay = context.insertAnimatedOverlay(
            backdropOn: true,
            modalBarrierOn: true,
            onTapOutside: () {
              overlay?.remove();
              overlay = null;
            },
            children: [
              PageHeaderOverlay(
                link: link,
                initialIndex: juzNums.last - 1,
                widgetKey: widgetKey,
                itemHeight: JuzNumberHeader.itemHeight,
                itemCount: 30,
                itemBuilder: (context, index) {
                  final isSelected = currentJuzNum == index + 1;

                  return Material(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary.withAlpha(38)
                        : Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        overlay?.remove();
                        overlay = null;

                        final isOnStrtPg = isOnJuzStartPage(
                          widget.currentPgIndex + 1,
                          index,
                          juzNums,
                        );

                        if (isOnStrtPg) return;

                        final targetUserPage = juzStartPage[index + 1]! - 1;
                        final targetIndex = dualPageMode
                            ? targetUserPage ~/ 2
                            : targetUserPage;

                        mushafPgCtrlProv.navigateToPage(
                          targetUserPage: targetUserPage,
                          targetIndex: targetIndex,
                          isSwipe: false,
                        );
                      },
                      child: SizedBox(
                        height: JuzNumberHeader.itemHeight,
                        child: Center(
                          child: Text(
                            'Juz ${index + 1}',
                            style: TextStyle(
                              fontWeight: isSelected ? .bold : .normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
        child: Text(
          'Juz $currentJuzNum',
          style: const TextStyle(
            decoration: .underline,
            decorationStyle: .dashed,
          ),
        ),
      ),
    );
  }
}
