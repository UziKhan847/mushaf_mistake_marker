import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/app_scroll_behaviour.dart';
import 'package:mushaf_mistake_marker/my_themes.dart';
import 'package:mushaf_mistake_marker/objectbox/object_box.dart';
import 'package:mushaf_mistake_marker/pages/loading_page.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';
import 'package:mushaf_mistake_marker/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(
      allowList: {
        'isDarkMode',
        'dualPageToggleOn',
        'initPage',
        'userId',
        'isDualPageMode',
        'isLeftHand',
        'isHighlightMode',
        'isAccountNavBtnSelected',
      },
    ),
  );

  objectbox = await ObjectBox.create();

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProv.overrideWithValue(prefs)],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      scrollBehavior: AppScrollBehaviour(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: Scaffold(
        body: LoadingPage(),
        backgroundColor: isDarkMode ? null : Color(0xFFFFF2EB),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

late final ObjectBox objectbox;
