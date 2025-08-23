import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';

final pageModeProvider = NotifierProvider<PageModeNotifer, bool>(
  PageModeNotifer.new,
);

class PageModeNotifer extends Notifier<bool> {
  @override
  bool build() => ref.read(sharedPrefsProv).getBool('savedPageMode') ?? false;

  void setPageMode() {
    final prefs = ref.read(sharedPrefsProv);
    state = !state;
    prefs.setBool('savedPageMode', state);
  }
}
