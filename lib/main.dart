import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/app_scroll_behaviour.dart';
import 'package:mushaf_mistake_marker/my_themes.dart';
import 'package:mushaf_mistake_marker/objectbox/object_box.dart';
import 'package:mushaf_mistake_marker/orientation_sync.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';
import 'package:mushaf_mistake_marker/providers/buttons/dark_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(
      allowList: {
        'isDarkMode',
        'appThemeIndex',
        'dualPageToggleOn',
        'initPage',
        'userId',
        'userMshfDataId',
        'userSettingsId',
        'isLeftHand',
        'isHighlightMode',
        'annotateMode',
      },
    ),
  );
  objectbox = await ObjectBox.create();
  runApp(
    ProviderScope(
      overrides: [sharedPrefsProv.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final appTheme = ref.watch(appThemeProvider);

    return MaterialApp(
      scrollBehavior: AppScrollBehaviour(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: MyThemes.lightTheme(appTheme),
      darkTheme: MyThemes.darkTheme(appTheme),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: OrientationSync(),
        backgroundColor: isDarkMode ? null : const Color(0xFFFFF2EB),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

late final ObjectBox objectbox;