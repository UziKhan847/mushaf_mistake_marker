import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_data.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_loading.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view_tile.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafPageView extends StatefulWidget {
  const MushafPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<MushafPageView> createState() => _MushafPageViewState();
}

class _MushafPageViewState extends State<MushafPageView> {
  late final pageController = widget.pageController;

  int prevPage = 0;

  final List<Map<String, MarkType>> markedPgs = List.generate(604, (_) => {}, growable: false);

  @override
  void initState() {
    super.initState();
    final initPage = pageController.initialPage;
    preFetchPages(initPage);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  //HELPER METHODS
  Future<void> fetchPage(int page) async {
    try {
      final fileString = await rootBundle.loadString('assets/${page + 1}.txt');
      final json = await compute(jsonDecode, fileString);
      final data = MushafPageData.fromJson(json);
      mushafPages[page] = data;
      setState(() {});
      print('Succesfully loaded page ${page + 1}');
    } catch (e) {
      print('Failed to load page ${page + 1}: $e');
    }
  }

  void clearPage(int page) {
    mushafPages[page] = null;
    print('Cleared page ${page + 1}');
  }

  void preFetchPages(int initPage) {
    fetchPage(initPage);

    if (initPage > 0) {
      fetchPage(initPage - 1);
    }

    if (initPage > 1) {
      fetchPage(initPage - 2);
    }

    if (initPage < 603) {
      fetchPage(initPage + 1);
    }

    if (initPage < 602) {
      fetchPage(initPage + 2);
    }
  }

  Future<void> _onPageChanged(int page) async {
    final swipedLeft = page > prevPage;

    if (swipedLeft) {
      if (page > 2) {
        clearPage(page - 3);
      }
      if (page < 602) {
        await fetchPage(page + 2);
      }
    } else {
      if (page < 601) {
        clearPage(page + 3);
      }
      if (page > 1) {
        await fetchPage(page - 2);
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
          return mushafPages[index] == null
              ? MushafPageLoading()
              : MushafPageViewTile(
                mushafPage: mushafPages[index],
                windowSize: MediaQuery.of(context).size,
                markedPaths: markedPgs[index],
              );
        },
      ),
    );
  }
}
