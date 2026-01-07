import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/app_scroll_behaviour.dart';
import 'package:mushaf_mistake_marker/my_themes.dart';
import 'package:mushaf_mistake_marker/objectbox/object_box.dart';
import 'package:mushaf_mistake_marker/orientation_sync.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(.immersiveSticky);

  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(
      allowList: {
        'isDarkMode',
        'dualPageToggleOn',
        'initPage',
        'userId',
        'userMshfDataId',
        'userSettingsId',
        'isLeftHand',
        'isHighlightMode',
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
      themeMode: isDarkMode ? .dark : .light,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: OrientationSync(),
        backgroundColor: isDarkMode ? null : Color(0xFFFFF2EB),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

late final ObjectBox objectbox;
