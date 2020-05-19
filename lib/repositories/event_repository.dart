import 'package:algolia/algolia.dart';
import 'package:collection/collection.dart';
import 'package:confs_tech/models/event_response.dart';
import 'package:confs_tech/models/events.dart';
import 'package:confs_tech/models/models.dart';

class EventRepository {

  static final Algolia algolia = Algolia.init(
    applicationId: '29FLVJV5X9',
    apiKey: 'f2534ea79a28d8469f4e81d546297d39',
  );

  Future<EventResponse> getEvents(
      String search,
      int page,
      List<Filter> selectedFilters,
      bool callForPaper,
      bool showPast
      ) async {
    int today = (new DateTime.now()
        .millisecondsSinceEpoch / 1000)
        .round();

    int oneYear = 365 * 24 * 60 * 60;

    String filters = showPast ? 'startDateUnix>${today - oneYear}' : 'startDateUnix>$today';

    AlgoliaQuery query = algolia.instance.index('prod_conferences')
        .setPage(page)
        .setHitsPerPage(30)
        .search(search);

    if (selectedFilters != null && selectedFilters.isNotEmpty)
      query = query.setFacetFilter(transformFilters(selectedFilters));

    if(callForPaper) {
      filters += " AND cfpEndDateUnix>$today";
    }

    query = query.setFilters(filters);
    AlgoliaQuerySnapshot snap = await query.getObjects();

    final List<Event> items = snap.hits.map((AlgoliaObjectSnapshot item) =>
        Event.fromJson(item.data)).toList();

    final hasMore = snap.page < snap.nbPages - 1;

    return EventResponse(events: items, page: snap.page, hasMore: hasMore,
        total: snap.nbHits, selectedFilters: selectedFilters);
  }

  static List<String> transformFilters(List<Filter> filters) {
    Map<String, List<Filter>> out = groupBy(filters, (filter) => filter.topic);

    List<String> outputList = [];

    final keyLength = out.keys.length;

    for(var i = 0; i < keyLength; i++){
      outputList.addAll(out[out.keys.elementAt(i)]
          .map((filter) => '${filter.topic}:${filter.key}'));
    }

    return outputList;
  }
}