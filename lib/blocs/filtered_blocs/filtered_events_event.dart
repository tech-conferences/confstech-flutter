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

  FilterUpdated({ this.selectedFilter = const [], this.facetName = ''});

  @override
  List<Object> get props => [selectedFilter, facetName];
}

class SearchChanged extends FilteredBlocsEvent {
  final String searchQuery;

  SearchChanged({ this.searchQuery = '' });

  @override
  List<Object> get props => [searchQuery];
}

class UpcomingSelected extends FilteredBlocsEvent {
  @override
  List<Object> get props => [];
}

class CallForPaperSelected extends FilteredBlocsEvent {
  @override
  List<Object> get props => [];
}

class ShowPastSelected extends FilteredBlocsEvent {
  @override
  List<Object> get props => [];
}