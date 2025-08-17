import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_loading.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view_tile.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';
import 'package:mushaf_mistake_marker/image/image_data.dart';
import 'package:mushaf_mistake_marker/sprite/orig_size.dart';
import 'package:mushaf_mistake_marker/sprite/rect_offset.dart';
import 'package:mushaf_mistake_marker/sprite/rst_offset.dart';
import 'package:mushaf_mistake_marker/sprite/sprite.dart';
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
    preFetchPage(initPage);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> fetchSprite(int index, int pageNumber) async {
    try {
      final spriteManifest = await rootBundle.loadString(
        'assets/sprite_manifests/$pageNumber.json',
      );

      final json =
          await compute(jsonDecode, spriteManifest) as Map<String, dynamic>;

      for (final e in json['sprites'] as List<dynamic>) {
        final sprite = Sprite.fromJson(e);

        spriteSheets[index].sprites.add(sprite);
      }
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  Future<void> fetchImg(int index, int pageNumber) async {
    try {
      final imgFile = await rootBundle.load(
        'assets/sprite_sheets_webp/$pageNumber.webp',
      );

      final codec = await ui.instantiateImageCodec(
        imgFile.buffer.asUint8List(),
      );

      final frame = await codec.getNextFrame();

      spriteSheets[index].image = frame.image;

      //return frame.image;
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  Future<void> fetchSpriteSheet(int index) async {
    final spriteSheet = spriteSheets[index];

    if (spriteSheet.sprites.isEmpty) {
      await fetchSprite(index, index + 1);
      print('Succesfully fetched Sprite Data of Page ${index + 1}');
    }

    if (spriteSheet.image == null) {
      await fetchImg(index, index + 1);
      print('Succesfully fetched Image of Page ${index + 1}');
    }

    setState(() {});
  }

  void clearImg(int index) {
    final spriteSheet = spriteSheets[index];
    spriteSheet.image = null;
    print('Cleared Page: ${index + 1}');
  }

  void preFetchPage(int initPage) {
    fetchSpriteSheet(initPage);

    if (initPage > 0) {
      fetchSpriteSheet(initPage - 1);
    }

    if (initPage > 1) {
      fetchSpriteSheet(initPage - 2);
    }

    if (initPage < 603) {
      fetchSpriteSheet(initPage + 1);
    }

    if (initPage < 602) {
      fetchSpriteSheet(initPage + 2);
    }
  }

  Future<void> _onPageChanged(int page) async {
    final swipedLeft = page > prevPage;

    if (swipedLeft) {
      if (page > 2) {
        clearImg(page - 3);
      }
      if (page < 602) {
        try {
          await fetchSpriteSheet(page + 2);
        } catch (e) {
          throw Exception('Exception. Error message: $e');
        }
      }
    } else {
      if (page < 601) {
        clearImg(page + 3);
      }
      if (page > 1) {
        try {
          await fetchSpriteSheet(page - 2);
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
          return spriteSheets[index].image == null
              ? MushafPageLoading()
              : MushafPageViewTile(
                  windowSize: MediaQuery.of(context).size,
                  markedPaths: markedPgs[index],
                  spriteSheet: spriteSheets[index],
                  pageData: widget.pages.pageData[index],
                );
        },
      ),
    );
  }
}
