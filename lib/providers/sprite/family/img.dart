import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sprImgProvider =
    AutoDisposeAsyncNotifierProviderFamily<
      SprImgProvider,
      ui.Image,
      int
    >(SprImgProvider.new);

class SprImgProvider
    extends AutoDisposeFamilyAsyncNotifier<ui.Image, int> {
  @override
  Future<ui.Image> build(int index) async {
    try {
      final pgNum = index + 1;

      final imgFile = await rootBundle.load(
        'assets/sprite_sheets_webp/$pgNum.webp',
      );

      final codec = await ui.instantiateImageCodec(
        imgFile.buffer.asUint8List(),
      );

      final frame = await codec.getNextFrame();

      return frame.image;
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }
}
