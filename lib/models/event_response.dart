import 'package:confs_tech/models/events.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class EventResponse extends Equatable {

  final List<Event> events;
  final int page;
  final int total;
  final bool hasMore;
  final List<Filter> selectedFilters;

  EventResponse({this.events, this.page, this.total, this.hasMore, this.selectedFilters});

  @override
  List<Object> get props => [events, page, total, hasMore, selectedFilters];

}