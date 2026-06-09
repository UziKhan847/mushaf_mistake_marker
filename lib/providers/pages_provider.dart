import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';

final pagesProvider = FutureProvider<Pages>((ref) async {
  final pageString = await rootBundle.loadString(
    'assets/old_madani_pages_data.json',
  );
  final json = jsonDecode(pageString);
  final pages = Pages.fromJson(json);
  return pages;
});
