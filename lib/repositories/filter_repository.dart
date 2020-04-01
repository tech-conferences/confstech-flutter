import 'dart:collection';

import 'package:algolia/algolia.dart';
import 'package:confs_tech/models/models.dart';

class FilterRepository {

  static final Algolia algolia = Algolia.init(
    applicationId: '29FLVJV5X9',
    apiKey: 'f2534ea79a28d8469f4e81d546297d39',
  );

  Future<Map<String, List<Filter>>> fetchAllFilters() async {
    final int today = (new DateTime.now()
        .millisecondsSinceEpoch / 1000)
        .round();

    AlgoliaQuery query = algolia.instance.index('prod_conferences')
        .setFilters('startDateUnix>$today')
        .setFacets(["topics", "country"]);

    AlgoliaQuerySnapshot snap = await query.getObjects();

    Map<String, List<Filter>> output = HashMap();

    snap.facets.entries.forEach((facet) {
      List<Filter> out = [];
      (facet.value as Map<String, dynamic>).forEach((name, count) {
        out.add(Filter(name: name, count: count, checked: false, topic: facet.key));
      });
      output.putIfAbsent(facet.key, () => out);
    });

    return output;
  }
}