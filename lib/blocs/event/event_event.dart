import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EventEvent extends Equatable {
  const EventEvent();
}

class FetchEvent extends EventEvent {
  final String searchQuery;
  final int page;
  final List<Filter> filters;

  FetchEvent({ this.searchQuery = '', this.page = 0, this.filters = const []});

  @override
  List<Object> get props => [searchQuery, page, filters];

  FetchEvent copyWith({
    String searchQuery,
    int page,
    List<Filter> filters
  }) {
    return FetchEvent(
        searchQuery: searchQuery ?? this.searchQuery,
        page: page ?? this.page,
        filters: filters ?? this.filters);
  }
}

class LoadMoreEvent extends EventEvent {
  @override
  List<Object> get props => [];
}

class ApplyFiltersEvent extends EventEvent {
  final List<Filter> filters;

  ApplyFiltersEvent(this.filters);

  @override
  List<Object> get props => [filters];
}