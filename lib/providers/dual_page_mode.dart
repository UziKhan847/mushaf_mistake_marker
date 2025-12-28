import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/buttons/dual_page.dart';
import 'package:mushaf_mistake_marker/providers/orientation.dart';

// final dualPgModeProvider = NotifierProvider<DualPageModeNotifier, bool>(
//   DualPageModeNotifier.new,
// );

// class DualPageModeNotifier extends Notifier<bool> {
//   @override
//   bool build() => false;

//   void setValue(bool isPortrait) {
//     final dualPgToggle = ref.read(dualPageToggleProvider);

//     final isDualPgMode = dualPgToggle && !isPortrait;

//     state = isDualPgMode;
//   }
// }

final dualPageModeProvider = Provider<bool>((ref) {
  final orientation = ref.watch(orientationProvider);
  final toggle = ref.watch(dualPageToggleProvider);

  return orientation == Orientation.landscape && toggle;
}, dependencies: [orientationProvider]);
