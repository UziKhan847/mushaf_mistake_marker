import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/page/page_view_builder.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller.dart';
import 'package:mushaf_mistake_marker/providers/orientation.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

class MushafPagePreFetcher extends ConsumerStatefulWidget {
  const MushafPagePreFetcher({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  ConsumerState<MushafPagePreFetcher> createState() => _MushafPageViewState();
}

class _MushafPageViewState extends ConsumerState<MushafPagePreFetcher> {
  late final spriteProv = ref.read(spriteProvider.notifier);
  late final initPage = ref.read(mushafPgCtrlProvider).initialPage;
  late final orientation = ref.read(orientationProvider);

  late final Future<void> data;

  @override
  void initState() {
    super.initState();

    data = Future.delayed(.zero, () => spriteProv.preFetchPages(initPage));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == .done) {
          return MushafPageViewBuilder(constraints: widget.constraints);
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
