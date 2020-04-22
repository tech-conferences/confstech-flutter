import 'package:algolia/algolia.dart';
import 'package:confs_tech/models/models.dart';

class FilterRepository {

  final Algolia algolia = Algolia.init(
    applicationId: '29FLVJV5X9',
    apiKey: 'f2534ea79a28d8469f4e81d546297d39',
  );

  Future<List<Filter>> fetchFilters(
      List<Filter> selectedFilters,
      bool callForPaper,
      String facetName,
      bool showPast
      ) async {
    final int today = (new DateTime.now()
        .millisecondsSinceEpoch / 1000)
        .round();

    int oneYear = 365 * 24 * 60 * 60;

    String filters = showPast ? 'startDateUnix>${today - oneYear}' : 'startDateUnix>$today';

    AlgoliaQuery query = algolia.instance.index('prod_conferences')
        .setMaxValuesPerFacet(100)
        .setFacets([facetName]);

    if(selectedFilters != null && selectedFilters.isNotEmpty) {
      query = query.setFacetFilter(transformFilters(selectedFilters));
    }

    if(callForPaper) {
      filters += " AND cfpEndDateUnix>$today";
    }

    query = query.setFilters(filters);

    AlgoliaQuerySnapshot snap = await query.getObjects();

    List<Filter> output = [];

    snap.facets.entries.forEach((facet) {
      (facet.value as Map<String, dynamic>).forEach((name, count) {
        output.add(Filter(name: name, count: count, checked: false, topic: facet.key));
      });
    });

    return output;
  }

  static List<String> transformFilters(List<Filter> filters) {
    return filters.map((filter) =>
    '${filter.topic}:${filter.name}').toList();
  }

}