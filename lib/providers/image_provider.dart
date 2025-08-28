// import 'dart:ui' as ui;
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final imageAsyncProvider = NotifierProvider.autoDispose
//     .family<ImageNotifier, ui.Image?, int>(ImageNotifier.new);

// class ImageNotifier extends AutoDisposeFamilyNotifier<ui.Image?, int> {

//   @override
//   ui.Image? build(int index) => null;

//   Future<void> fetchImage(int pageNumber) async {
//      final imgFile = await rootBundle.load(
//       'assets/sprite_sheets_webp/$pageNumber.webp',
//     );

//     final codec = await ui.instantiateImageCodec(imgFile.buffer.asUint8List());

//     final frame = await codec.getNextFrame();

//     state = frame.image;
//   }
// }

// final imageAsyncProvider = AsyncNotifierProvider.autoDispose
//     .family<ImageNotifier, ui.Image, int>(ImageNotifier.new);

// class ImageNotifier extends AutoDisposeFamilyAsyncNotifier<ui.Image, int> {

//   @override
//   Future<ui.Image> build(int pageNumber) async {
//     final imgFile = await rootBundle.load(
//       'assets/sprite_sheets_webp/$pageNumber.webp',
//     );

//     final codec = await ui.instantiateImageCodec(imgFile.buffer.asUint8List());

//     final frame = await codec.getNextFrame();

//     return frame.image;
//   }
// }

