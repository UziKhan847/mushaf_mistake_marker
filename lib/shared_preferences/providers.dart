import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProv = Provider<SharedPreferencesWithCache>(
  (ref) => throw UnimplementedError(),
);

final isDualPageProv = StateProvider<bool>((ref) => false);

final isDarkModeProv = StateProvider<bool>((ref) => false);
