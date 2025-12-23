import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/store.dart';

final elementDataBoxProvider = Provider<Box<ElementData>>(
  (ref) => ref.read(objectBoxStoreProvider).box<ElementData>(),
);
