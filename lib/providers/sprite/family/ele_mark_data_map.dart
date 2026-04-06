import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final sprElemDataMapProvider = Provider.autoDispose
    .family<Map<String, ElementMarkData>, int>((ref, index) {
      final sprites = ref.read(spriteProvider)[index].sprMnfst;

      final sprElemIds = sprites.map((e) => e.id).toList();

      if (sprElemIds.isEmpty) {
        return {};
      }

      final userMshfData = ref.watch(userMushafDataProvider);

      if (userMshfData == null) return {};

      final mshfDataId = userMshfData.id;

      final eleDataBox = ref.read(elementMarkDataBoxProvider);

      final query = eleDataBox
          .query(
            ElementMarkData_.key.oneOf(sprElemIds) &
                ElementMarkData_.mushafData.equals(mshfDataId),
          )
          .build();

      final elementList = query.find();

      query.close();

      final elementMap = {for (final e in elementList) e.key: e};

      return elementMap;
    });
