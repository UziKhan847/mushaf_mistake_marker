import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/store.dart';

final settingsBoxProvider = Provider<Box<UserSettings>>(
  (ref) => ref.read(objectBoxStoreProvider).box<UserSettings>()
);