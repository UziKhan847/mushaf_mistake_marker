import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageRebuildProvider =
    AutoDisposeNotifierProviderFamily<PageRebuildNotifier, bool, int>(
      PageRebuildNotifier.new,
    );

class PageRebuildNotifier extends AutoDisposeFamilyNotifier<bool, int> {
  @override
  bool build(int index) => false;

  void update() {
    state = !state;
  }
}
