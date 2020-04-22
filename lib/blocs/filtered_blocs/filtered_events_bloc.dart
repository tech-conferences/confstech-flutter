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
      FilteredBlocsEvent event,) async* {
    final currentState = state;
    if (event is FilterUpdated) {
      if (currentState is FilteredEventsLoaded) {
        final finalFilters = List<Filter>.from(currentState.selectedFilters);
        finalFilters.retainWhere((filter) => filter.topic != event.facetName);
        finalFilters.addAll(event.selectedFilter);

        yield currentState.copyWith(selectedFilters: finalFilters,
            showPast: false, showCallForPapers: false);
      } else {
        yield FilteredEventsLoaded(selectedFilters: event.selectedFilter,
            showPast: false, showCallForPapers: false);
      }
    } else if (event is SearchChanged) {
      if (currentState is FilteredEventsLoaded) {
        yield currentState.copyWith(
            searchQuery: event.searchQuery, selectedFilters: const []);
      } else {
        yield FilteredEventsLoaded(
            searchQuery: event.searchQuery, selectedFilters: const []);
      }
    } else if (event is CallForPaperChanged) {
      yield FilteredEventsLoaded(showCallForPapers: event.showCallForPapers);
    } else if (event is ShowPastChanged) {
      yield FilteredEventsLoaded(showPast: event.showPast);
    }
  }
}
