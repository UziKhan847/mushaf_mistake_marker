import 'dart:ui' as ui;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final whiteRectProvider = NotifierProvider<WhiteRectNotifier, ui.Image?>(
  WhiteRectNotifier.new,
);

class WhiteRectNotifier extends Notifier<ui.Image?> {
  @override
  ui.Image? build() => null;

  Future<void> generateImg() async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    canvas.drawRect(
      const ui.Rect.fromLTWH(0, 0, 1.0, 1.0),
      ui.Paint()..color = const ui.Color(0xFFFFFFFF),
    );

    state = await recorder.endRecording().toImage(1, 1);
  }
}
