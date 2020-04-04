import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:confs_tech/models/models.dart';
import 'package:confs_tech/repositories/filter_repository.dart';

import '../bloc.dart';

class EventFilterBloc extends Bloc<EventFilterEvent, EventFilterState> {
  final FilterRepository filterRepository;

  EventFilterBloc({ this.filterRepository });

  @override
  EventFilterState get initialState => InitialEventFilterState();

  @override
  Stream<EventFilterState> mapEventToState(
      EventFilterEvent event,
      ) async* {
    final currentState = state;

    if (event is FetchFilters) {
      try {
        yield FilterLoading();
        List<Filter> filters = await this.filterRepository.fetchAllFilters();

        if(currentState.selectedFilters.isNotEmpty){
          filters = filters.map((filter) =>
          currentState.selectedFilters.any((selectedFilter) =>
          selectedFilter.name == filter.name) ? filter.copyWith(checked: true) :
          filter).toList();
        }

        yield FilterLoaded(filters: filters, selectedFilters: currentState.selectedFilters);
      }catch(_) {
        yield FilterError();
      }
    } else if (event is SetFilterCheckboxChecked) {
      if(currentState is FilterLoaded) {
        final output = currentState.filters.map((filter) =>
        filter.name == event.filter.name ? event.filter : filter).toList();

        final selected = event.filter.checked ?
        (currentState.selectedFilters + [event.filter]) :
        (List<Filter>.from(currentState.selectedFilters)..removeWhere((
            filter) => event.filter.name == filter.name));

        yield FilterLoaded(filters: output, selectedFilters: selected);
      }
    } else if (event is ClearFiltersEvent) {
      if(currentState is FilterLoaded) {
        yield FilterApplied(selectedFilters: const <Filter>[]);
      }
    }else if(event is ApplyFiltersEvent) {
      if(currentState is FilterLoaded) {
        yield FilterApplied(selectedFilters: currentState.selectedFilters);
      }
    }
  }
}