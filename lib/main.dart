import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/app_scroll_behaviour.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_data.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final List<MushafPageData?> mushafPages = List.generate(
  604,
  (_) => null,
  growable: false,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehaviour(),
      home: Scaffold(backgroundColor: Colors.white, body: MushafPageView()),
      debugShowCheckedModeBanner: false,
    );
  }
}
