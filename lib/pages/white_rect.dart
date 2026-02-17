// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mushaf_mistake_marker/pages/loading.dart';
// import 'package:mushaf_mistake_marker/providers/white_rect.dart';

// class WhiteRectPage extends ConsumerWidget {
//   const WhiteRectPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ref
//         .watch(whiteRectProvider)
//         .when(
//           data: (pages) => LoadingPage(),
//           error: (e, st) => Center(child: Text('Error: $e')),
//           loading: () => Center(child: CircularProgressIndicator()),
//         );
//   }
// }
