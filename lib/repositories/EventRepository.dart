import 'package:algolia/algolia.dart';
import 'package:confs_tech/models/event_response.dart';
import 'package:confs_tech/models/events.dart';

class EventRepository {

  static final Algolia algolia = Algolia.init(
    applicationId: '29FLVJV5X9',
    apiKey: 'f2534ea79a28d8469f4e81d546297d39',
  );

  Future<EventResponse> getEvents(String search, int page) async {
    int today = (new DateTime.now()
        .millisecondsSinceEpoch / 1000)
        .round();

    AlgoliaQuery query = algolia.instance.index('prod_conferences')
        .setFilters('startDateUnix>$today')
        .setPage(page)
        .search(search);

    AlgoliaQuerySnapshot snap = await query.getObjects();

    final List<Event> items = snap.hits.map((AlgoliaObjectSnapshot item) =>
        Event.fromJson(item.data)).toList();

    final hasMore = snap.page < snap.nbPages;

    return EventResponse(events: items, page: snap.page, hasMore: hasMore,
        total: snap.nbHits);
  }
}