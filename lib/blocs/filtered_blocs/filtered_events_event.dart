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
  List<Object> get props => [selectedFilter];
}

class SearchChanged extends FilteredBlocsEvent {
  final String searchQuery;

  SearchChanged({ this.searchQuery = '' });

  @override
  List<Object> get props => [searchQuery];
}

class CallForPaperChanged extends FilteredBlocsEvent {
  final bool showCallForPapers;

  CallForPaperChanged({ this.showCallForPapers = false });

  @override
  List<Object> get props => [showCallForPapers];
}