import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/extensions/string_extension.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/juz.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/surahs.dart';

class MarginLantern extends ConsumerWidget {
  const MarginLantern({super.key, required this.pIndex});

  final int pIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahs = ref.watch(pageSurahsProvider(pIndex));
    final juzNums = ref.watch(juzProvider(pIndex));
    final cs = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == .dark;
    const squareW = 30.0;
    const imgH = squareW * 3;

    return Column(
      mainAxisAlignment: .center,
      mainAxisSize: .min,
      spacing: 5,
      children: [
        juzNums == null
            ? SizedBox.shrink()
            : Text(
                'J${juzNums.last}'.verticalText,
                textAlign: .center,
                style: TextStyle(fontWeight: .w500, height: 1.0, fontSize: 12),
              ),
        SizedBox(
          height: imgH,
          width: squareW,
          child: Stack(
            alignment: .center,
            children: [
              Image.asset(
                'assets/images/margin_lantern.png',
                color: isDarkMode
                    ? cs.outlineVariant
                    : cs.outline.withAlpha(170),
                width: squareW,
                height: imgH,
              ),
              SizedBox(
                width: squareW - 10,
                child: FittedBox(
                  fit: .scaleDown,
                  child: Text(
                    '${pIndex + 1}',
                    textAlign: .center,
                    style: TextStyle(fontWeight: .w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        surahs == null
            ? SizedBox.shrink()
            : Text(
                'S${surahs[0].number}'.verticalText,
                textAlign: .center,
                style: TextStyle(fontWeight: .w500, height: 1.0, fontSize: 12),
              ),
      ],
    );
  }
}
