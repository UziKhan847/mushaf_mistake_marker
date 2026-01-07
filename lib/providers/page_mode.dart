import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/buttons/dual_page.dart';
import 'package:mushaf_mistake_marker/providers/orientation.dart';

final pageModeProvider = Provider<bool>((ref) {
  final orientation = ref.watch(orientationProvider);
  final toggle = ref.watch(dualPageToggleProvider);

  return orientation == Orientation.landscape && toggle;
});
