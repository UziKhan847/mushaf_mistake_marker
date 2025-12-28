import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/user.dart';

final userSettingsProvider = Provider<UserSettings?>(
  (ref) => ref.watch(userProvider).settings.target,
);
