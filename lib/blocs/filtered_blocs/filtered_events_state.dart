import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class FilteredEventsState extends Equatable {
  final List<Filter> selectedFilters;
  final String searchQuery;
  final bool showCallForPapers;

  const FilteredEventsState({ this.selectedFilters = const <Filter>[],
    this.searchQuery = '', this.showCallForPapers = false});
}

class FilteredEventsLoading extends FilteredEventsState {

  @override
  List<Object> get props => [];
}

class FilteredEventsLoaded extends FilteredEventsState {
  FilteredEventsLoaded({ selectedFilters = const <Filter>[], searchQuery = '',
    showCallForPapers = false}):
        super(selectedFilters: selectedFilters, searchQuery: searchQuery,
          showCallForPapers: showCallForPapers);

  @override
  List<Object> get props => [selectedFilters, searchQuery, showCallForPapers];

  FilteredEventsLoaded copyWith({
    List<Filter> selectedFilters,
    String searchQuery,
    bool showCallForPapers,
  }) {
    return FilteredEventsLoaded(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilters: selectedFilters ?? this.selectedFilters,
      showCallForPapers: showCallForPapers ?? this.showCallForPapers,
    );
  }
}