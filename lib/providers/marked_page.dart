import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';

final markedPageProvider =
    AutoDisposeAsyncNotifierProviderFamily<
      MarkedPageProvider,
      Map<String, MarkType>,
      int
    >(MarkedPageProvider.new);

class MarkedPageProvider
    extends AutoDisposeFamilyAsyncNotifier<Map<String, MarkType>, int> {
  @override
  Future<Map<String, MarkType>> build(int pageNumber) async {
    return {};
  }
}
