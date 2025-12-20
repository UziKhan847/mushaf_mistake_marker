import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/main.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';

final objectBoxStoreProvider = Provider<Store>((ref) => objectbox.store);
