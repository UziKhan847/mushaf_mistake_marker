import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';
import 'package:mushaf_mistake_marker/pages/homepage.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late final Future<Pages> data;

  @override
  void initState() {
    super.initState();

    data = fetchPages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Pages> fetchPages() async {
    final pageString = await rootBundle.loadString('assets/page_data.txt');

    final json = await jsonDecode(pageString);

    final pages = Pages.fromJson(json);

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        if (snapshot.hasData) {
          final pages = snapshot.data!;

          return Homepage(pages: pages);
        }

        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
