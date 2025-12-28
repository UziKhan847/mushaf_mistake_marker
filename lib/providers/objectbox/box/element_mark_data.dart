import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/store.dart';

final elementMarkDataBoxProvider = Provider<Box<ElementMarkData>>(
  (ref) => ref.read(objectBoxStoreProvider).box<ElementMarkData>(),
);
