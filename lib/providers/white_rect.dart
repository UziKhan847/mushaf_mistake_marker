import 'dart:ui' as ui;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final whiteRectProvider = NotifierProvider<WhiteRectNotifier, ui.Image?>(
  WhiteRectNotifier.new,
);

class WhiteRectNotifier extends Notifier<ui.Image?> {
  @override
  ui.Image? build() => null;

  Future<void> generateImg() async {
    const size = 1.0;

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    canvas.drawRect(
      const ui.Rect.fromLTWH(0, 0, size, size),
      ui.Paint()..color = const ui.Color(0xFFFFFFFF),
    );

    try {
      state = await recorder.endRecording().toImage(size.toInt(), size.toInt());
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }
}
