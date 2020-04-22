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
  final bool showCallForPapers;

  FetchEvent({ this.searchQuery = '', this.page = 0, this.filters = const [],
    this.showCallForPapers = false,});

  @override
  List<Object> get props => [searchQuery, page, filters, showCallForPapers];

  FetchEvent copyWith({
    String searchQuery,
    int page,
    List<Filter> filters,
    bool callForPapers
  }) {
    return FetchEvent(
        searchQuery: searchQuery ?? this.searchQuery,
        page: page ?? this.page,
        filters: filters ?? this.filters,
        showCallForPapers: callForPapers ?? this.showCallForPapers
    );
  }
}

class LoadMoreEvent extends EventEvent {
  @override
  List<Object> get props => [];
}