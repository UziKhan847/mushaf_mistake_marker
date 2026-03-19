import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/extensions/string_extension.dart';

class MarginLantern extends StatelessWidget {
  const MarginLantern({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const squareW = 30.0;
    const imgH = squareW * 3;

    return Column(
      mainAxisAlignment: .center,
      mainAxisSize: .min,
      spacing: 5,
      children: [
        Text(
          'J25'.verticalText,
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
                'assets/images/margin_lantern_2.png',
                color: cs.outline.withAlpha(170),
                width: squareW,
                height: imgH,
              ),
              SizedBox(
                width: squareW - 10,
                child: FittedBox(
                  fit: .scaleDown,
                  child: Text(
                    '555',
                    textAlign: .center,
                    style: TextStyle(fontWeight: .w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          'S113'.verticalText,
          textAlign: .center,
          style: TextStyle(fontWeight: .w500, height: 1.0, fontSize: 12),
        ),
      ],
    );
  }
}
