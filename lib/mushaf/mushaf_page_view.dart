import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_loading.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view_tile.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';
import 'package:mushaf_mistake_marker/image/image_data.dart';
import 'package:mushaf_mistake_marker/image/image_page.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafPageView extends StatefulWidget {
  const MushafPageView({
    super.key,
    required this.pageController,
    required this.pages,
  });

  final PageController pageController;
  final Pages pages;

  @override
  State<MushafPageView> createState() => _MushafPageViewState();
}

class _MushafPageViewState extends State<MushafPageView> {
  late final pageController = widget.pageController;

  int prevPage = 0;

  final List<Map<String, MarkType>> markedPgs = List.generate(
    604,
    (_) => {},
    growable: false,
  );

  @override
  void initState() {
    super.initState();
    final initPage = pageController.initialPage;
    preFetchImagePages(initPage);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> fetchImagePageData(
    int pageNumber,
    List<ImageData> _imageDataList,
  ) async {
    try {
      final manifest = await rootBundle.loadString(
        'assets/manifests_12_scale/$pageNumber.json',
      );

      // final manifest = await rootBundle.loadString(
      //   'assets/manifests_12_scale/$pageNumber.json',
      // );

      final json = await compute(jsonDecode, manifest) as List<dynamic>;

      for (final e in json) {
        final imageData = ImageData.fromJson(e);

        _imageDataList.add(imageData);
      }
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  Future<ui.Image> fetchImg(String id, int pageNumber) async {
    try {
      final imgFile = await rootBundle.load(
        'assets/webp_pages_12_scale/$pageNumber/$id.webp',
      );

      // final imgFile = await rootBundle.load(
      //   'assets/webp_12_scale/$pageNumber.webp',
      // );

      final codec = await ui.instantiateImageCodec(
        imgFile.buffer.asUint8List(),
      );

      final frame = await codec.getNextFrame();

      // imageMushaf.pages[index].image = frame.image;

      return frame.image;
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  Future<void> fetchImagePageImgs(
    int index,
    int pageNumber,
    List<ImageData> _imageDataList,
  ) async {
    for (final e in _imageDataList) {
      final image = await fetchImg(e.id, pageNumber);
      final page = imageMushaf.pages[index];

      page.pageImages[e.id] = image;
    }
  }

  Future<void> fetchImageMushafPage(int index) async {
    final page = imageMushaf.pages[index];

    if (page.imageDataList.isEmpty) {
      await fetchImagePageData(index + 1, page.imageDataList);
      print('Succesfully fetched Data of Page ${index + 1}');
    }

    if (page.pageImages.isEmpty) {
      //await fetchImg(index, index + 1);
      await fetchImagePageImgs(index, index + 1, page.imageDataList);
      print('Succesfully fetched Image of Page ${index + 1}');
    }

    //print(page.image);

    setState(() {});
  }

  void clearImagePageImg(int index) {
    final page = imageMushaf.pages[index];
    page.pageImages.clear();
    //page.image = null;
    print('Cleared Page: ${index + 1}');
  }

  void preFetchImagePages(int initPage) {
    fetchImageMushafPage(initPage);

    if (initPage > 0) {
      fetchImageMushafPage(initPage - 1);
    }

    if (initPage > 1) {
      fetchImageMushafPage(initPage - 2);
    }

    if (initPage < 603) {
      fetchImageMushafPage(initPage + 1);
    }

    if (initPage < 602) {
      fetchImageMushafPage(initPage + 2);
    }
  }

  Future<void> _onPageChanged(int page) async {
    final swipedLeft = page > prevPage;

    if (swipedLeft) {
      if (page > 2) {
        clearImagePageImg(page - 3);
      }
      if (page < 602) {
        try {
          await fetchImageMushafPage(page + 2);
        } catch (e) {
          throw Exception('Exception. Error message: $e');
        }
      }
    } else {
      if (page < 601) {
        clearImagePageImg(page + 3);
      }
      if (page > 1) {
        try {
          await fetchImageMushafPage(page - 2);
        } catch (e) {
          throw Exception('Exception. Error message: $e');
        }
      }
    }

    prevPage = page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        reverse: true,
        onPageChanged: _onPageChanged,
        controller: pageController,
        itemCount: 604,
        itemBuilder: (context, index) {
          final imagePage = imageMushaf.pages[index];
          final pageData = widget.pages.pageData[index];

          final numOfEle = imagePage.imageDataList.length;
          final numOfImgs = imagePage.pageImages.length;

          final isLoaded =
              numOfImgs == numOfEle && imagePage.pageImages.isNotEmpty;

          return !isLoaded
              ? MushafPageLoading()
              : MushafPageViewTile(
                  windowSize: MediaQuery.of(context).size,
                  markedPaths: markedPgs[index],
                  imagePage: imagePage,
                  pageData: pageData,
                );
        },
      ),
    );
  }
}
