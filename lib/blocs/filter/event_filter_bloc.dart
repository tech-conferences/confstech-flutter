import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:confs_tech/models/models.dart';
import 'package:confs_tech/repositories/filter_repository.dart';
import 'package:flutter/widgets.dart';

import '../bloc.dart';

class EventFilterBloc extends Bloc<EventFilterEvent, EventFilterState> {
  final FilterRepository filterRepository;
  final FilteredEventsBloc filteredEventsBloc;

  EventFilterBloc({ @required this.filterRepository,
    @required this.filteredEventsBloc });

  @override
  EventFilterState get initialState => FilterLoading();

  @override
  Stream<EventFilterState> mapEventToState(
      EventFilterEvent event,
      ) async* {
    final currentState = state;

    if (event is FetchFilters) {
      try {
        yield FilterLoading();
        final selectedFilters = filteredEventsBloc.state.selectedFilters;

        List<Filter> filters = await this.filterRepository
            .fetchFilters(event.topic);

        final finalFilters = filters.map((fetchedEvent){
            return selectedFilters.any((selectedFilter) =>
            fetchedEvent.name == selectedFilter.name) ?
            fetchedEvent.copyWith(checked: true) : fetchedEvent;
          }).toList();

        yield FilterLoaded(filters: finalFilters);
      }catch(_) {
        yield FilterError();
      }
    } else if (event is SetFilterCheckboxChecked) {
      if(currentState is FilterLoaded) {
        final filters = currentState.filters
            .map((filter) => filter.name == event.filter.name ?
        event.filter.copyWith(checked: event.checked) : filter).toList();

        yield FilterLoaded(filters: filters);
      }
    } else if (event is ClearFiltersEvent) {
      if(currentState is FilterLoaded) {
        final filters = currentState.filters
            .map((filter) => filter.copyWith(checked: false))
            .toList();

        yield FilterLoaded(filters: filters);
      }
    } else if (event is ApplyFilters) {
      if(currentState is FilterLoaded) {
        final selectedFilters = List<Filter>.from(currentState.filters)
            .where((event) => event.checked == true).toList();
        this.filteredEventsBloc.add(FilterUpdated(selectedFilters));
      }
    }
  }
}
