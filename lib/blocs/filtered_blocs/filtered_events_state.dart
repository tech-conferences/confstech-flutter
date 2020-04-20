import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class FilteredEventsState extends Equatable {
  final List<Filter> selectedFilters;
  final String searchQuery;

  const FilteredEventsState({ this.selectedFilters = const <Filter>[],
    this.searchQuery = ''});
}

class InitialFilteredEventsState extends FilteredEventsState {
  @override
  List<Object> get props => [];
}

class FilteredEventsLoading extends FilteredEventsState {

  @override
  List<Object> get props => [];
}

class FilteredEventsLoaded extends FilteredEventsState {
  FilteredEventsLoaded({ selectedFilters = const <Filter>[], searchQuery = '' }):
        super(selectedFilters: selectedFilters, searchQuery: searchQuery);

  @override
  List<Object> get props => [selectedFilters, searchQuery];

  FilteredEventsLoaded copyWith({
    List<Filter> selectedFilters,
    String searchQuery
  }) {
    return FilteredEventsLoaded(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilters: selectedFilters ?? this.selectedFilters,
    );
  }
}