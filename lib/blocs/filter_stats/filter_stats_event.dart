import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class FilterStatsEvent extends Equatable {
  const FilterStatsEvent();
}

class UpdateStats extends FilterStatsEvent {
  final List<Filter> filters;

  UpdateStats(this.filters);

  @override
  List<Object> get props => [filters];
}