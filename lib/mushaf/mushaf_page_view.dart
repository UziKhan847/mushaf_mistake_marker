import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_loading.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view_tile.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';
import 'package:mushaf_mistake_marker/png/png_data.dart';
import 'package:mushaf_mistake_marker/png/png_page.dart';
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
    preFetchPngPages(initPage);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }



  Future<void> fetchPngPageData(
    int pageNumber,
    List<PngData> _pngDataList,
  ) async {
    try {
      final manifest = await rootBundle.loadString(
        'assets/manifests/$pageNumber.json',
      );

      final json = await compute(jsonDecode, manifest) as List<dynamic>;

      for (final e in json) {
        final pngData = PngData.fromJson(e);

        _pngDataList.add(pngData);
      }
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  Future<ui.Image> fetchPngImg(String id, int pageNumber) async {
    try {
      final imgFile = await rootBundle.load('assets/webp/$pageNumber/$id.webp');

      final codec = await ui.instantiateImageCodec(
        imgFile.buffer.asUint8List(),
      );

      final frame = await codec.getNextFrame();

      return frame.image;
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  Future<void> fetchPngPageImgs(
    int index,
    int pageNumber,
    List<PngData> _pngDataList,
  ) async {
    for (final e in _pngDataList) {
      final image = await fetchPngImg(e.id, pageNumber);
      final page = pngMushaf.pages[index];

      page.pageImages[e.id] = image;
    }
  }

  Future<void> fetchPngMushafPage(int index) async {
    final page = pngMushaf.pages[index];

    if (page.pngDataList.isEmpty) {
      await fetchPngPageData(index + 1, page.pngDataList);
    }

    if (page.pageImages.isEmpty) {
      await fetchPngPageImgs(index, index + 1, page.pngDataList);
    }

    setState(() {});
  }

  void clearPngPageImg(int index) {
    final page = pngMushaf.pages[index];
    page.pageImages.clear();
  }

  void preFetchPngPages(int initPage) {
    fetchPngMushafPage(initPage);

    if (initPage > 0) {
      fetchPngMushafPage(initPage - 1);
    }

    if (initPage > 1) {
      fetchPngMushafPage(initPage - 2);
    }

    if (initPage < 603) {
      fetchPngMushafPage(initPage + 1);
    }

    if (initPage < 602) {
      fetchPngMushafPage(initPage + 2);
    }
  }

  Future<void> _onPageChanged(int page) async {
    final swipedLeft = page > prevPage;

    if (swipedLeft) {
      if (page > 2) {
        clearPngPageImg(page - 3);
      }
      if (page < 602) {
        try {
          await fetchPngMushafPage(page + 2);
        } catch (e) {
          throw Exception('Exception. Error message: $e');
        }
      }
    } else {
      if (page < 601) {
        clearPngPageImg(page + 3);
      }
      if (page > 1) {
        try {
          await fetchPngMushafPage(page - 2);
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
          final pngPage = pngMushaf.pages[index];
          final pageData = widget.pages.pageData[index];

          final numOfEle = pngPage.pngDataList.length;
          final numOfImgs = pngPage.pageImages.length;

          final isLoaded =
              numOfImgs == numOfEle && pngPage.pageImages.isNotEmpty;

          return isLoaded
              ? MushafPageViewTile(
                  windowSize: MediaQuery.of(context).size,
                  markedPaths: markedPgs[index],
                  pngPage: pngPage,
                  pageData: pageData,
                )
              : MushafPageLoading();
        },
      ),
    );
  }
}
