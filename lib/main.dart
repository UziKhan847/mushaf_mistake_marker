import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/app_scroll_behaviour.dart';
import 'package:mushaf_mistake_marker/pages/loading_page.dart';
import 'package:mushaf_mistake_marker/shared_preferences/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(allowList: {'isDualPage'}),
  );

  final isDualPage = prefs.getBool('isDualPage') ?? false;

  final isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProv.overrideWithValue(prefs),
        isDualPageProv.overrideWith((ref) => isDualPage),
        isDarkModeProv.overrideWith((ref) => isDarkMode),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(isDarkModeProv);

    return MaterialApp(
      scrollBehavior: AppScrollBehaviour(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        backgroundColor: const Color(0xFFFEF9F5),
        body: LoadingPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
