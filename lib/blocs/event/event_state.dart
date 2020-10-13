import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:confs_tech/models/models.dart';

@immutable
abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventEmpty extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> event;
  final bool hasMore;
  final currentQuery;
  final currentPage;
  final List<Filter> selectedFilters;
  final bool showCallForPapers;
  final bool showPast;

  const EventLoaded(
      {@required this.event,
      this.hasMore,
      this.currentQuery,
      this.currentPage,
      this.selectedFilters,
      this.showCallForPapers,
      this.showPast})
      : assert(event != null);

  EventLoaded copyWith(
      {List<Event> events,
      bool hasMore,
      String currentQuery,
      int currentPage,
      List<Filter> selectedFilters,
      bool callForPapers,
      bool showPast}) {
    return EventLoaded(
        event: events ?? this.event,
        hasMore: hasMore ?? this.hasMore,
        currentQuery: currentQuery ?? this.currentQuery,
        currentPage: currentPage ?? this.currentPage,
        selectedFilters: selectedFilters ?? this.selectedFilters,
        showCallForPapers: callForPapers ?? this.showCallForPapers,
        showPast: showPast ?? this.showPast);
  }

  @override
  List<Object> get props =>
      [event, hasMore, currentPage, currentQuery, showCallForPapers, showPast];

  @override
  String toString() {
    return 'EventLoaded(event: $event, hasMore: $hasMore, currentQuery: $currentQuery, currentPage: $currentPage, selectedFilters: $selectedFilters, showCallForPapers: $showCallForPapers, showPast: $showPast)';
  }
}

class EventError extends EventState {}
