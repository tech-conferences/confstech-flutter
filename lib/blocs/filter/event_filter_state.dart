import 'package:confs_tech/models/filters.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EventFilterState extends Equatable {
  final List<Filter> selectedFilters;

  EventFilterState({ this.selectedFilters = const []});
}

class InitialEventFilterState extends EventFilterState {
  @override
  List<Object> get props => [];
}

class FilterLoading extends EventFilterState {
  @override
  List<Object> get props => [];
}

class FilterLoaded extends EventFilterState {
  final String topic;
  final List<Filter> filters;

  FilterLoaded({ this.filters, this.topic, selectedFilters }) :
        super(selectedFilters:  selectedFilters);

  @override
  List<Object> get props => [filters, topic];
}

class FilterError extends EventFilterState {
  @override
  List<Object> get props => null;
}

class FiltersAdded extends EventFilterState {
  final List<String> checkedFilters;

  FiltersAdded(this.checkedFilters);

  @override
  List<Object> get props => [checkedFilters];
}

class FilterCheckboxChecked extends EventFilterState {
  final Filter filter;

  FilterCheckboxChecked(this.filter);

  @override
  List<Object> get props => [filter];
}

class FilterApplied extends EventFilterState {
  FilterApplied({ selectedFilters }) : super(selectedFilters: selectedFilters);

  @override
  List<Object> get props => [selectedFilters];
}