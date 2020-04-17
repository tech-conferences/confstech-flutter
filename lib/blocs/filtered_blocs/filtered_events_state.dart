import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class FilteredEventsState extends Equatable {
  final List<Filter> selectedFilters;

  const FilteredEventsState({ this.selectedFilters = const [] });
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
  FilteredEventsLoaded({ selectedFilters }):
        super(selectedFilters: selectedFilters);

  @override
  List<Object> get props => [selectedFilters];
}