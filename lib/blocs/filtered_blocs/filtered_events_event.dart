import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class FilteredBlocsEvent extends Equatable {
  const FilteredBlocsEvent();
}

class FilterUpdated extends FilteredBlocsEvent {
  final List<Filter> selectedFilter;
  final String facetName;

  FilterUpdated(this.selectedFilter, this.facetName);

  @override
  List<Object> get props => [selectedFilter];
}