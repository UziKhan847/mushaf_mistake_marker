import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_pager.dart';
import 'package:mushaf_mistake_marker/providers/page_mode_provider.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';
import 'package:mushaf_mistake_marker/providers/sprite_provider.dart';

class MushafPageView extends ConsumerStatefulWidget {
  const MushafPageView({
    super.key,
    required this.constraints,
    required this.isPortrait,
  });

  final BoxConstraints constraints;
  final bool isPortrait;

  @override
  ConsumerState<MushafPageView> createState() => _MushafPageViewState();
}

class _MushafPageViewState extends ConsumerState<MushafPageView>
    with AutomaticKeepAliveClientMixin {
  late final mushfaPgCrtl = ref.read(mushafPgCtrlProvider);
  late final initPage = mushfaPgCrtl.initialPage;
  late final spriteProv = ref.read(spriteProvider.notifier);
  late final prefs = ref.read(sharedPrefsProv);
  //late int prevPage;

  late final List<Map<String, MarkType>> markedPgs = List.generate(
    604,
    (_) => {},
    growable: false,
  );

  late final Future<void> data;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    data = spriteProv.preFetchPages(initPage, widget.isPortrait);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDualPage = ref.watch(pageModeProvider);
    final isDualPageMode = isDualPage && !widget.isPortrait;
    prefs.setBool('isDualPageMode', isDualPageMode);

    return FutureBuilder(
      future: data,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MushafPager(
            isDualPageMode: isDualPageMode,
            controller: mushfaPgCrtl,
            markedPgs: markedPgs,
            constraints: widget.constraints,
            ref: ref,
            isPortrait: isDualPageMode ? false : widget.isPortrait,
            initPage: initPage,
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
