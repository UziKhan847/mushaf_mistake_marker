// import 'dart:convert';
// import 'dart:ui' as ui;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mushaf_mistake_marker/mushaf/mushaf_page_loading.dart';
// import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view_tile.dart';
// import 'package:mushaf_mistake_marker/page_data/pages.dart';
// import 'package:mushaf_mistake_marker/image/image_data.dart';
// import 'package:mushaf_mistake_marker/variables.dart';

// class MushafPageView extends StatefulWidget {
//   const MushafPageView({
//     super.key,
//     required this.pageController,
//     required this.pages,
//   });

//   final PageController pageController;
//   final Pages pages;

//   @override
//   State<MushafPageView> createState() => _MushafPageViewState();
// }

// class _MushafPageViewState extends State<MushafPageView> {
//   late final pageController = widget.pageController;

//   int prevPage = 0;

//   final List<Map<String, MarkType>> markedPgs = List.generate(
//     604,
//     (_) => {},
//     growable: false,
//   );

//   @override
//   void initState() {
//     super.initState();
//     final initPage = pageController.initialPage;
//     preFetchImagePages(initPage);
//   }

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }

//   Future<void> fetchImagePageData(
//     int pageNumber,
//     List<ImageData> _imageDataList,
//   ) async {
//     try {
//       final manifest = await rootBundle.loadString(
//         'assets/manifests/$pageNumber.json',
//       );

//       final json = await compute(jsonDecode, manifest) as List<dynamic>;

//       for (final e in json) {
//         final imageData = ImageData.fromJson(e);

//         _imageDataList.add(imageData);
//       }
//     } catch (e) {
//       throw Exception('Exception. Error message: $e');
//     }
//   }

//   Future<ui.Image> fetchImg(String id, int pageNumber) async {
//     try {
//       final imgFile = await rootBundle.load(
//         'assets/webp_pages_12_scale/$pageNumber/$id.webp',
//       );

//       // final imgFile = await rootBundle.load(
//       //   'assets/webp_12_scale/$pageNumber.webp',
//       // );

//       final codec = await ui.instantiateImageCodec(
//         imgFile.buffer.asUint8List(),
//       );

//       final frame = await codec.getNextFrame();

//       // imageMushaf.pages[index].image = frame.image;

//       return frame.image;
//     } catch (e) {
//       throw Exception('Exception. Error message: $e');
//     }
//   }

//   Future<void> fetchImagePageImgs(
//     int index,
//     int pageNumber,
//     List<ImageData> _imageDataList,
//   ) async {
//     for (final e in _imageDataList) {
//       final image = await fetchImg(e.id, pageNumber);
//       final page = imageMushaf.pages[index];

//       page.pageImages[e.id] = image;
//     }
//   }

//   Future<void> fetchImageMushafPage(int index) async {
//     final page = imageMushaf.pages[index];

//     if (page.imageDataList.isEmpty) {
//       await fetchImagePageData(index + 1, page.imageDataList);
//       print('Succesfully fetched Data of Page ${index + 1}');
//     }

//     if (page.pageImages.isEmpty) {
//       //await fetchImg(index, index + 1);
//       await fetchImagePageImgs(index, index + 1, page.imageDataList);
//       print('Succesfully fetched Image of Page ${index + 1}');
//     }

//     //print(page.image);

//     setState(() {});
//   }

//   void clearImagePageImg(int index) {
//     final page = imageMushaf.pages[index];
//     page.pageImages.clear();
//     //page.image = null;
//     print('Cleared Page: ${index + 1}');
//   }

//   void preFetchImagePages(int initPage) {
//     fetchImageMushafPage(initPage);

//     if (initPage > 0) {
//       fetchImageMushafPage(initPage - 1);
//     }

//     if (initPage > 1) {
//       fetchImageMushafPage(initPage - 2);
//     }

//     if (initPage < 603) {
//       fetchImageMushafPage(initPage + 1);
//     }

//     if (initPage < 602) {
//       fetchImageMushafPage(initPage + 2);
//     }
//   }

//   Future<void> _onPageChanged(int page) async {
//     final swipedLeft = page > prevPage;

//     if (swipedLeft) {
//       if (page > 2) {
//         clearImagePageImg(page - 3);
//       }
//       if (page < 602) {
//         try {
//           await fetchImageMushafPage(page + 2);
//         } catch (e) {
//           throw Exception('Exception. Error message: $e');
//         }
//       }
//     } else {
//       if (page < 601) {
//         clearImagePageImg(page + 3);
//       }
//       if (page > 1) {
//         try {
//           await fetchImageMushafPage(page - 2);
//         } catch (e) {
//           throw Exception('Exception. Error message: $e');
//         }
//       }
//     }

//     prevPage = page;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: PageView.builder(
//         reverse: true,
//         onPageChanged: _onPageChanged,
//         controller: pageController,
//         itemCount: 604,
//         itemBuilder: (context, index) {
//           final imagePage = imageMushaf.pages[index];
//           final pageData = widget.pages.pageData[index];

//           final numOfEle = imagePage.imageDataList.length;
//           final numOfImgs = imagePage.pageImages.length;

//           final isLoaded =
//               numOfImgs == numOfEle && imagePage.pageImages.isNotEmpty;

//           return !isLoaded
//               ? MushafPageLoading()
//               : MushafPageViewTile(
//                   windowSize: MediaQuery.of(context).size,
//                   markedPaths: markedPgs[index],
//                   imagePage: imagePage,
//                   pageData: pageData,
//                 );
//         },
//       ),
//     );
//   }
// }



//====================


// import 'package:flutter/material.dart';
// import 'package:mushaf_mistake_marker/mushaf/mushaf_page_painter.dart';
// import 'package:mushaf_mistake_marker/page_data/page_data.dart';
// import 'package:mushaf_mistake_marker/image/image_page.dart';
// import 'package:mushaf_mistake_marker/variables.dart';

// class MushafPageViewTile extends StatefulWidget {
//   const MushafPageViewTile({
//     super.key,
//     required this.windowSize,
//     required this.markedPaths,
//     required this.imagePage,
//     required this.pageData,
//   });

//   //final int pageNumber;
//   final Size windowSize;
//   final ImagePage imagePage;
//   final PageData pageData;
//   final Map<String, MarkType> markedPaths;

//   @override
//   State<MushafPageViewTile> createState() => _MushafPageViewTileState();
// }

// class _MushafPageViewTileState extends State<MushafPageViewTile> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   bool elemBounds({
//     required double top,
//     required double bottom,
//     required double left,
//     required double right,
//     required double scaledX,
//     required double scaledY,
//   }) {
//     return scaledX >= left &&
//         scaledY >= top &&
//         scaledX <= right &&
//         scaledY <= bottom;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final markedPaths = widget.markedPaths;

//     final imageDataList = widget.imagePage.imageDataList;
//     final images = widget.imagePage.pageImages;
//     //final image = widget.imagePage.image;

//     final pageW = widget.pageData.width;
//     final pageH = widget.pageData.height;

//     final w = widget.windowSize.width * 0.85;

//     final h = w * (pageH / pageW);

//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(minHeight: widget.windowSize.height),
//         child: Center(
//           child: SizedBox(
//             width: w,
//             height: h,
//             child: GestureDetector(
//               onTapDown: (details) {
//                 final localPos = details.localPosition;

//                 final scaleX = w / pageW;
//                 final scaleY = h / pageH;

//                 final scaledPoint = Offset(
//                   localPos.dx / scaleX,
//                   localPos.dy / scaleY,
//                 );

//                 for (final e in imageDataList) {
//                   final (id, left, top, right, bottom, scaledX, scaledY) = (
//                     e.id,
//                     e.offset.dx,
//                     e.offset.dy,
//                     e.origSize.width + e.offset.dx,
//                     e.origSize.height + e.offset.dy,
//                     scaledPoint.dx,
//                     scaledPoint.dy,
//                   );

//                   final isClicked = elemBounds(
//                     top: top,
//                     bottom: bottom,
//                     left: left,
//                     right: right,
//                     scaledX: scaledX,
//                     scaledY: scaledY,
//                   );

//                   if (!id.contains(RegExp(r'[bc]')) && isClicked) {
//                     switch (markedPaths[id]) {
//                       case MarkType.doubt:
//                         markedPaths[id] = MarkType.mistake;
//                       case MarkType.mistake:
//                         markedPaths[id] = MarkType.oldMistake;
//                       case MarkType.oldMistake:
//                         markedPaths[id] = MarkType.tajwid;
//                       case MarkType.tajwid:
//                         markedPaths.remove(id);
//                       default:
//                         markedPaths[id] = MarkType.doubt;
//                     }

//                     print('-----------------------------------');
//                     print('Clicked Element: $id');

//                     setState(() {});
//                   }
//                 }
//               },
//               child: CustomPaint(
//                 painter: MushafPagePainter(
//                   vBoxSize: Size(pageW, pageH),
//                   markedPaths: Map.from(markedPaths),
//                   imagePage: widget.imagePage,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//=======================

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:mushaf_mistake_marker/image/image_page.dart';
// import 'package:mushaf_mistake_marker/variables.dart';

// class MushafPagePainter extends CustomPainter {
//   MushafPagePainter({
//     required this.imagePage,
//     //required this.paths,
//     required this.vBoxSize,
//     required this.markedPaths,
//   });

//   //final List<DrawablePath> paths;
//   final ImagePage imagePage;
//   final Size vBoxSize;
//   final Map<String, MarkType> markedPaths;

//   ColorFilter changeColor(Color color) =>
//       ColorFilter.mode(color, BlendMode.srcIn);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..filterQuality = FilterQuality.high;
//     //final ePaint = Paint()..filterQuality = FilterQuality.high;

//     final double scaleX = size.width / vBoxSize.width;
//     final double scaleY = size.height / vBoxSize.height;
//     final imageDataList = imagePage.imageDataList;
//     final images = imagePage.pageImages;
//     //final image = imagePage.image!;

//     canvas.scale(scaleX, scaleY);

//     for (final e in imageDataList) {
//       final id = e.id;
//       final offset = e.offset;
//       final eSize = e.origSize;
//       final image = images[id];

//       switch (markedPaths[id]) {
//         case MarkType.doubt:
//           paint.colorFilter = changeColor(Colors.purple);
//         case MarkType.mistake:
//           paint.colorFilter = changeColor(Colors.red);
//         case MarkType.oldMistake:
//           paint.colorFilter = changeColor(Colors.blue);
//         case MarkType.tajwid:
//           paint.colorFilter = changeColor(Colors.green);
//         default:
//           paint.colorFilter = changeColor(Colors.black);
//       }

//       // canvas.drawRect(
//       //   Rect.fromLTWH(offset.dx, offset.dy, eSize.width, eSize.height),
//       //   ePaint,
//       // );

//       if (image != null) {
//         canvas.drawImage(image, offset, paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant MushafPagePainter oldDelegate) =>
//       !mapEquals(oldDelegate.markedPaths, markedPaths);
// }
