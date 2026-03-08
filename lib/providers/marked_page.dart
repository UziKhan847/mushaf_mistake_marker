import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';

final markedPageProvider =
    AutoDisposeAsyncNotifierProviderFamily<
      MarkedPageProvider,
      Map<String, HighlightType>,
      int
    >(MarkedPageProvider.new);

class MarkedPageProvider
    extends AutoDisposeFamilyAsyncNotifier<Map<String, HighlightType>, int> {
  @override
  Future<Map<String, HighlightType>> build(int pageNumber) async {
    return {};
  }
}
