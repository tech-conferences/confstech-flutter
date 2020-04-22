import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:confs_tech/models/filters.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc.dart';

class FilteredEventsBloc extends Bloc<FilteredBlocsEvent, FilteredEventsState> {
  FilteredEventsBloc();

  @override
  FilteredEventsState get initialState => FilteredEventsLoading();

  @override
  Stream<FilteredEventsState> transformEvents(Stream<FilteredBlocsEvent> events,
      Stream<FilteredEventsState> Function(FilteredBlocsEvent) next) {
    final nonDebounceStream =
      events
          .where((event) => event is! SearchChanged);
    final debounceStream = events
        .where((event) => event is SearchChanged)
        .debounceTime(Duration(milliseconds: 300));
    return MergeStream([nonDebounceStream, debounceStream]).switchMap(next);
  }

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

        yield currentState.copyWith(selectedFilters: finalFilters);
      } else {
        yield FilteredEventsLoaded(selectedFilters: event.selectedFilter);
      }
    } else if (event is SearchChanged) {
      if(currentState is FilteredEventsLoaded) {
        yield currentState.copyWith(searchQuery: event.searchQuery);
      } else {
        yield FilteredEventsLoaded(searchQuery: event.searchQuery);
      }
    } else if (event is CallForPaperChanged) {
      if(currentState is FilteredEventsLoaded) {
        yield currentState.copyWith(showCallForPapers: event.showCallForPapers);
      } else {
        yield FilteredEventsLoaded(showCallForPapers: event.showCallForPapers);
      }
    }
  }
}
