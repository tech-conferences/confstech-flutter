import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FilterStatsState extends Equatable {
  const FilterStatsState();
}

class FilterStatsLoading extends FilterStatsState {
  @override
  List<Object> get props => [];
}

class FilterStatsLoaded extends FilterStatsState {
  final int selectedFilters;
  final int topicFilters;
  final int countryFilters;

  FilterStatsLoaded({
    this.selectedFilters = 0,
    this.topicFilters = 0,
    this.countryFilters = 0
  });

  @override
  List<Object> get props => [selectedFilters, topicFilters, countryFilters];
}