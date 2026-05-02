import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageIdsProvider =
    AsyncNotifierProvider.family<PageIdsNotifier, List<String>, int>(
      PageIdsNotifier.new,
    );

class PageIdsNotifier extends AsyncNotifier<List<String>> {
  PageIdsNotifier(this.index);
  final int index;

  @override
  Future<List<String>> build() async =>
      jsonDecode(await rootBundle.loadString('assets/sprite_ids/$index.json'))
          as List<String>;
}
