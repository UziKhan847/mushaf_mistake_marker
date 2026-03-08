import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painters/bubble.dart';

class MarkBubble extends StatelessWidget {
  const MarkBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(),
      child: IntrinsicWidth(
        child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    TextField(textAlign: .center),
                    Container(height: 1, color: Colors.amber),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(onPressed: () {}, child: Text('Doubt')),
                        TextButton(onPressed: () {}, child: Text('Mistake')),
                        TextButton(
                          onPressed: () {},
                          child: Text('Old Mistake'),
                        ),
                        TextButton(onPressed: () {}, child: Text('Tajwid')),
                        TextButton(onPressed: () {}, child: Text('None')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
