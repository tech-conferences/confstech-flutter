import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventEmpty extends EventState {}

class EventUninitialized extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> event;
  final bool hasMore;
  final currentQuery;
  final currentPage;
  final List<Filter> selectedFilters;

  const EventLoaded({@required this.event, this.hasMore, this.currentQuery,
    this.currentPage, this.selectedFilters})
      : assert(event != null);

  EventLoaded copyWith({
    List<Event> events,
    bool hasMore,
    String currentQuery,
    int currentPage,
    List<Filter> selectedFilters,
  }) {
    return EventLoaded(
        event: events ?? this.event,
        hasMore: hasMore ?? this.hasMore,
        currentQuery: currentQuery ?? this.currentQuery,
        currentPage: currentPage ?? this.currentPage,
        selectedFilters: selectedFilters ?? this.selectedFilters
    );
  }

  @override
  List<Object> get props => [event, hasMore, currentPage, currentQuery];
}

class EventError extends EventState {}