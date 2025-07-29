import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/app_scroll_behaviour.dart';
import 'package:mushaf_mistake_marker/pages/homepage.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehaviour(),
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
