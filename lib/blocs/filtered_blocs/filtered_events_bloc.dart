import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:confs_tech/models/filters.dart';

import '../bloc.dart';

class FilteredEventsBloc extends Bloc<FilteredBlocsEvent, FilteredEventsState> {
  FilteredEventsBloc();

  @override
  FilteredEventsState get initialState => FilteredEventsLoading();

  @override
  Stream<FilteredEventsState> mapEventToState(
    FilteredBlocsEvent event,
  ) async* {
    final currentState = state;
    if (event is FilterUpdated) {
      if(currentState is FilteredEventsLoaded) {
        final finalFilters = List<Filter>.from(currentState.selectedFilters);
        finalFilters.retainWhere((filter) => filter.topic != event.facetName);
        finalFilters.addAll(event.selectedFilter);

        yield FilteredEventsLoaded(selectedFilters: finalFilters);
      } else {
        yield FilteredEventsLoaded(selectedFilters: event.selectedFilter);
      }
    }
  }
}
