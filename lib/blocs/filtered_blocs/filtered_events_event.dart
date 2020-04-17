import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class FilteredBlocsEvent extends Equatable {
  const FilteredBlocsEvent();
}

class FilterUpdated extends FilteredBlocsEvent {
  final List<Filter> selectedFilter;

  FilterUpdated(this.selectedFilter);

  @override
  List<Object> get props => [selectedFilter];
}

class EventUpdated extends FilteredBlocsEvent {
  final List<Event> events;

  EventUpdated(this.events);

  @override
  List<Object> get props => [events];
}