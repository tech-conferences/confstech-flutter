import 'package:equatable/equatable.dart';

abstract class FilterStatsState extends Equatable {
  const FilterStatsState();
}

class FilterStatsLoading extends FilterStatsState {
  @override
  List<Object> get props => [];
}

class FilterStatsLoaded extends FilterStatsState {
  final int selectedFilters;

  FilterStatsLoaded(this.selectedFilters);

  @override
  List<Object> get props => [selectedFilters];
}