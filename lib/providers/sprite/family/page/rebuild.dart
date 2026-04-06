import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageRebuildProvider = NotifierProvider.autoDispose
    .family<PageRebuildNotifier, bool, int>(PageRebuildNotifier.new);

class PageRebuildNotifier extends Notifier<bool> {
  PageRebuildNotifier(this.index);
  final int index;

  @override
  bool build() => false;

  void update() {
    state = !state;
  }
}
