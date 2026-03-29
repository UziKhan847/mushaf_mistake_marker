import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';

final appThemeProvider = NotifierProvider<AppThemeNotifier, AppTheme>(
  AppThemeNotifier.new,
);

class AppThemeNotifier extends Notifier<AppTheme> {
  @override
  AppTheme build() {
    final index = ref.read(sharedPrefsProv).getInt('appThemeIndex') ?? 0;
    return AppTheme.fromThemeIndex(index);
  }

  void setTheme(AppTheme theme) {
    state = theme;
    ref.read(sharedPrefsProv).setInt('appThemeIndex', theme.id);
  }
}
