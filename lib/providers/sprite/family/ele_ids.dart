import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page_data.dart';

final sprEleIdsProvider =
    AutoDisposeAsyncNotifierProviderFamily<
      SprElesProvider,
      List<ElementData>?,
      int
    >(SprElesProvider.new);

class SprElesProvider
    extends AutoDisposeFamilyAsyncNotifier<List<ElementData>?, int> {
  @override
  Future<List<ElementData>?> build(int index) async {
    try {
      final sprPgData = ref.watch(sprPgDataProvider(index)).valueOrNull;

      if (sprPgData == null) {
        return null;
      }

      final sprEleIds = sprPgData.map((e) => e.id).toList();

      if (sprEleIds.isEmpty) {
        return null;
      }

      final (userMshfDataId, eleDataBox) = (
        ref.read(userMushafDataProvider)!.id,
        ref.read(elementDataBoxProvider),
      );

      final query = eleDataBox
          .query(
            ElementData_.key.oneOf(sprEleIds) &
                ElementData_.mushafData.equals(userMshfDataId),
          )
          .build();

      final elements = query.find();

      query.close();

      if (elements.isEmpty) {
        return null;
      }

      return elements;
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }
}
