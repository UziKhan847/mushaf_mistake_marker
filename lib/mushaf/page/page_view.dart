import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/page/builder.dart';
import 'package:mushaf_mistake_marker/providers/buttons/dual_page.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

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
  late final mushafPgCrtl = ref.read(mushafPgCtrlProvider);
  late final initPage = mushafPgCrtl.initialPage;
  late final spriteProv = ref.read(spriteProvider.notifier);
  late final prefs = ref.read(sharedPrefsProv);

  late final Future<void> data;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    data = Future.delayed(
      .zero,
      () => spriteProv.preFetchPages(initPage, widget.isPortrait),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDualPage = ref.watch(dualPageToggleProvider);
    final isDualPageMode = isDualPage && !widget.isPortrait;

    return FutureBuilder(
      future: data,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == .done) {
          return MushafPageBuilder(
            isDualPageMode: isDualPageMode,
            controller: mushafPgCrtl,
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
