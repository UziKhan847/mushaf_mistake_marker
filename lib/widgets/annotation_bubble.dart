import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/atlas_models/cache.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/mushaf/page/annotator_handler.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painters/bubble.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/rebuild.dart';
import 'package:mushaf_mistake_marker/widgets/annotation_button.dart';

class AnnotationBubble extends ConsumerWidget {
  const AnnotationBubble({
    super.key,
    required this.atlasCache,
    required this.atlasIndex,
    required this.index,
    required this.onTaps,
  });

  final AtlasCache atlasCache;
  final int atlasIndex;
  final int index;
  final List<VoidCallback> onTaps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(pageRebuildProvider(index));
    final isDarkMode = Theme.of(context).brightness == .dark;
    final colors = isDarkMode ? annotateDarkColors : annotateLightColors;
    final selectedColors = isDarkMode
        ? annotateLightColors
        : annotateDarkColors;
    final selectedTextColor = isDarkMode ? Colors.black : Colors.white;
    final highlight = AnnotatorHandler.highlightFromColor(
      atlasCache.highlighColorList[atlasIndex],
    );

    return Material(
      color: Colors.transparent,
      child: CustomPaint(
        painter: BubblePainter(),
        child: SizedBox(
          width: 250,
          child: Padding(
            padding: const .only(bottom: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 34,
                  child: TextField(
                    textAlign: .center,
                    decoration: InputDecoration(
                      contentPadding: .only(bottom: 10),
                    ),
                  ),
                ),
                const Divider(thickness: 0, height: 0),
                Row(
                  children: .generate(annotateLabels.length, (i) {
                    return AnnotationButton(
                      label: annotateLabels[i],
                      color: colors[i],
                      selectedColor: selectedColors[i],
                      selectedTextColor: selectedTextColor,
                      isSelected: highlight == highlightTypes[i],
                      onTap: onTaps[i],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
