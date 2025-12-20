import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page_data.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_ele_data.dart';

final sprEleIdsProvider =
    AutoDisposeAsyncNotifierProviderFamily<
      SprEleIdsProvider,
      List<ElementData>?,
      int
    >(SprEleIdsProvider.new);

class SprEleIdsProvider
    extends AutoDisposeFamilyAsyncNotifier<List<ElementData>?, int> {
  @override
  Future<List<ElementData>?> build(int index) async {
    try {
      final sprPgData = ref.read(sprPgDataProvider(index)).valueOrNull;

      if (sprPgData == null) {
        return null;
      }

      final sprEleIds = getSprEleIds(sprPgData);

      return [];
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  List<String> getSprEleIds(List<SpriteEleData> sprPgData) {
    final sprEleIds = <String>[];

    for (final e in sprPgData) {
      final id = e.id;
      sprEleIds.add(id);
    }

    return sprEleIds;
  }
}
