import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mushaf_mistake_marker/main.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_data.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view_tile.dart';

class MushafPageView extends StatefulWidget {
  const MushafPageView({super.key});

  @override
  State<MushafPageView> createState() => _MushafPageViewState();
}

class _MushafPageViewState extends State<MushafPageView> {
  late final pageController = PageController(initialPage: 0);

  int prevPage = 0;

  @override
  void initState() {
    super.initState();

    final initP = pageController.initialPage;
    final initmushafP = initP + 1;

    loadPage(initP, initmushafP);

    if (initP > 0) {
      loadPage(initP - 1, initmushafP - 1);
    }

    if (initP > 1) {
      loadPage(initP - 2, initmushafP - 2);
    }

    if (initP < 603) {
      loadPage(initP + 1, initmushafP + 1);
    }

    if (initP < 602) {
      loadPage(initP + 2, initmushafP + 2);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> loadPage(int page, int mushafPage) async {
    try {
      final fileString = await rootBundle.loadString('assets/$mushafPage.txt');
      print('String loaded from $mushafPage.txt');
      final json = await compute(jsonDecode, fileString);
      print('Decoded json in compute');
      final data = MushafPageData.fromJson(json);
      print('Converted Json to Mushaf Page $mushafPage');
      mushafPages[page] = data;
      setState(() {});
    } catch (e) {
      print('Failed to load page: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      reverse: true,
      onPageChanged: (page) async {
        final swipedLeft = page > prevPage;

        final mushafPage = page + 1;

        if (swipedLeft) {
          if (page < 602 && mushafPages[page + 2] == null) {
            await loadPage(page + 2, mushafPage + 2);

            if (page < 601 && mushafPages[page + 3] == null) {
              await loadPage(page + 3, mushafPage + 3);
            }

            if (page < 600 && mushafPages[page + 4] == null) {
              await loadPage(page + 4, mushafPage + 4);
            }

            if (page < 599 && mushafPages[page + 5] == null) {
              await loadPage(page + 5, mushafPage + 5);
            }
          }
        } else {
          if (page > 1 && mushafPages[page - 2] == null) {
            await loadPage(page - 2, mushafPage - 2);

            if (page > 2 && mushafPages[page - 3] == null) {
              await loadPage(page - 3, mushafPage - 3);
            }

            if (page > 3 && mushafPages[page - 4] == null) {
              await loadPage(page - 4, mushafPage - 4);
            }

            if (page > 4 && mushafPages[page - 5] == null) {
              await loadPage(page - 5, mushafPage - 5);
            }
          }
        }

        prevPage = page;
      },
      controller: pageController,
      itemCount: 604,
      itemBuilder: (context, index) {
        return mushafPages[index] == null
            ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [CircularProgressIndicator(), Text('Loading Page')],
              ),
            )
            : MushafPageViewTile(
              mushafPage: mushafPages[index],
              windowSize: MediaQuery.of(context).size,
            );
      },
    );
  }
}
