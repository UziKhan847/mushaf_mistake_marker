import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/store.dart';

final mushafDataProvider = Provider<Box<UserMushafData>>(
  (ref) => ref.read(objectBoxStoreProvider).box<UserMushafData>(),
);
