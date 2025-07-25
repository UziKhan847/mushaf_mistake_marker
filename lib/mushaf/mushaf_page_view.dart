import 'dart:convert';
import 'dart:io' show Platform, File;
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
  late final pageController = PageController(initialPage: 603);

  late Stream<MushafPageData?> data;

  @override
  void initState() {
    super.initState();
    data = pageStream();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Stream<MushafPageData?> pageStream() async* {
    final stopWatch = Stopwatch()..start();

    for (int i = 0; i < 100; i++) {
      if (mushafPages[i] != null) {
        continue;
      }

      final fileString = await rootBundle.loadString('assets/${i + 1}.txt');

      print('String loaded from ${i + 1}.txt');

      final json = await compute(jsonDecode, fileString);

      print('Decoded json in computer');

      final data = MushafPageData.fromJson(json);

      print('Converted Json to Mushaf Page ${i + 1}');

      yield data;
    }

    stopWatch.stop();

    print('Finish in: ${stopWatch.elapsedMilliseconds}');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: data,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Center(child: Text('Error: ${asyncSnapshot.error}'));
        }

        if (asyncSnapshot.hasData) {
          final data = asyncSnapshot.data!;

          final index = data.pageNumber - 1;

          mushafPages[index] = data;
        }

        if (mushafPages[5] != null) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return PageView.builder(
                // onPageChanged: (index) async {
                //   final loadingPageN = 603 - index + 20;

                //   if (mushafPages[loadingPageN - 1] == null) {
                //     final fileString = await rootBundle.loadString(
                //       'assets/$loadingPageN.txt',
                //     );

                //     print('String loaded from $loadingPageN.txt');

                //     final json = await compute(jsonDecode, fileString);

                //     print('Decoded json in computer');

                //     final data = MushafPageData.fromJson(json);

                //     print('Converted Json to Mushaf Page $loadingPageN');

                //     mushafPages[loadingPageN - 1] = data;
                //   }
                // },
                controller: pageController,
                itemCount: 604,
                itemBuilder: (context, index) {
                  return MushafPageViewTile(
                    mushafPage: mushafPages[603 - index],
                    windowSize: Size(
                      constraints.maxWidth,
                      constraints.maxHeight,
                    ),
                  ); //604 - index (for backwards)
                },
              );
            },
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [CircularProgressIndicator(), Text('Setting things up!')],
          ),
        );
      },
    );
  }
}
