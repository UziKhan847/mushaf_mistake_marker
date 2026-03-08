import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painters/bubble.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/rebuild.dart';
import 'package:mushaf_mistake_marker/widgets/annotation_button.dart';

class AnnotationBubble extends ConsumerWidget {
  const AnnotationBubble({
    super.key,
    required this.hightlight,
    required this.index,
    required this.onTaps,
  });

  final HighlightType hightlight;
  final int index;
  final List<VoidCallback> onTaps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageRebuild = ref.watch(pageRebuildProvider(index));
    final isDarkMode = Theme.of(context).brightness == .dark;
    final colors = isDarkMode ? annotateDarkColors: annotateLightColors;

    return Material(
      color: Colors.transparent,
      child: CustomPaint(
        painter: BubblePainter(),
        child: SizedBox(
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 34,
                  child: TextField(
                    textAlign: .center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10),
                    ),
                  ),
                ),
                const Divider(thickness: 0, height: 0),
                Row(
                  mainAxisAlignment: .spaceEvenly,
                  children: List.generate(annotateLabels.length, (i) {
                    return AnnotationButton(
                      label: annotateLabels[i],
                      color: colors[i],
                      isSelected: hightlight == hightlightTypes[i],
                      isSelectedColor: colors[i].withAlpha(100),
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
