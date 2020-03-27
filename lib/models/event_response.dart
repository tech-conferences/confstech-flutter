import 'package:confs_tech/models/events.dart';
import 'package:equatable/equatable.dart';

class EventResponse extends Equatable {

  final List<Event> events;
  final int page;
  final int total;
  final bool hasMore;

  EventResponse({this.events, this.page, this.total, this.hasMore});

  @override
  List<Object> get props => [events, page, total, hasMore];

}