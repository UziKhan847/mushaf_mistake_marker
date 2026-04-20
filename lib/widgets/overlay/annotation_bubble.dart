import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/mushaf/annotator_handler.dart';
import 'package:mushaf_mistake_marker/mushaf/painters/bubble.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/cached_atlas.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/element.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/rebuild.dart';
import 'package:mushaf_mistake_marker/widgets/buttons/annotation.dart';

class AnnotationBubble extends ConsumerStatefulWidget {
  const AnnotationBubble({
    super.key,
    required this.pgIndex,
    required this.atlasIndex,
    required this.elemId,
    this.isBubbleTop = true,
    this.trianglePos = .bottomCenter,
  });

  final int pgIndex;
  final int atlasIndex;
  final String elemId;
  final bool isBubbleTop;
  final TrianglePosition trianglePos;

  @override
  ConsumerState<AnnotationBubble> createState() => _AnnotationBubbleState();
}

class _AnnotationBubbleState extends ConsumerState<AnnotationBubble> {
  late final TextEditingController txtCtrl;
  late final elemBox = ref.read(elementMarkDataBoxProvider);
  late final mshfData = ref.read(userMushafDataProvider)!;
  late final mshfDataBox = ref.read(mushafDataBoxProvider);
  late final pageRebuildProv = ref.read(
    pageRebuildProvider(widget.pgIndex).notifier,
  );
  late final elemProv = ref.read(elementProvider(widget.elemId).notifier);
  late final atlasCacheProv = ref.read(
    cachedAtlasProvider(widget.pgIndex).notifier,
  );

  @override
  void initState() {
    super.initState();
    final element = ref.read(elementProvider(widget.elemId));
    txtCtrl = TextEditingController(text: element?.annotation ?? '');
  }

  @override
  void dispose() {
    txtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final element = ref.watch(elementProvider(widget.elemId));
    final isDarkMode = Theme.brightnessOf(context) == .dark;

    final colors = isDarkMode
        ? annotateDarkColors['unselected']
        : annotateLightColors['unselected'];
    final selectedColors = isDarkMode
        ? annotateDarkColors['selected']
        : annotateLightColors['selected'];
    final selectedTextColor = isDarkMode ? Colors.black : Colors.white;

    return Material(
      color: Colors.transparent,
      child: CustomPaint(
        painter: BubblePainter(
          trianglePos: widget.trianglePos,
          isDarkMode: isDarkMode,
        ),
        child: SizedBox(
          width: annotateBubbleWidth,
          child: Padding(
            padding: .only(
              bottom: widget.isBubbleTop ? 15.0 : 0.0,
              top: widget.isBubbleTop ? 0.0 : 15.0,
            ),
            child: Container(
              clipBehavior: .hardEdge,
              decoration: BoxDecoration(
                borderRadius: AnnotatorHandler.getBubbleBorderRadius(
                  widget.trianglePos,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 34,
                    child: TextField(
                      controller: txtCtrl,
                      onChanged: (String annotation) {
                        if (element == null) {
                          elemProv.addElement(
                            //key: widget.elemId,
                            annotation: annotation,
                          );
                        } else {
                          element.updateAnnotation(annotation);
                          elemProv.updateElement(element);
                          if (element.isEmpty) elemProv.removeElement(element);
                        }

                        atlasCacheProv.updateElementColor(
                          widget.pgIndex,
                          widget.atlasIndex,
                          isDarkMode,
                          element,
                        );
                      },
                      textAlign: .center,
                      decoration: const InputDecoration(
                        contentPadding: .only(bottom: 10),
                      ),
                    ),
                  ),
                  const Divider(thickness: 0, height: 0),
                  Row(
                    children: List.generate(annotateLabels.length, (i) {
                      final buttonHighlight = highlightTypes[i];
                      final isSelected = element == null
                          ? HighlightType.unknown == buttonHighlight
                          : element.highlight == buttonHighlight;

                      return AnnotationButton(
                        label: annotateLabels[i],
                        color: colors![i],
                        selectedColor: selectedColors![i],
                        selectedTextColor: selectedTextColor,
                        isSelected: isSelected,
                        onTap: () {
                          if (isSelected) return;

                          if (element == null) {
                            elemProv.addElement(
                              //key: widget.elemId,
                              highlight: buttonHighlight,
                            );
                          } else {
                            element.updateHighlight(buttonHighlight);
                            elemProv.updateElement(element);
                            if (element.isEmpty) {
                              elemProv.removeElement(element);
                            }
                          }

                          atlasCacheProv.updateElementColor(
                            widget.pgIndex,
                            widget.atlasIndex,
                            isDarkMode,
                            element,
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
