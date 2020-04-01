import 'dart:async';

import 'package:bloc/bloc.dart';
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
        Map<String, dynamic> filters = await this.filterRepository.fetchAllFilters();
        yield FilterLoaded(filters: filters);
      }catch(_) {
        yield FilterError();
      }
    } else if (event is AddNewFilters) {
      yield FiltersAdded(event.checkedFilters);
    } else if (event is SetFilterCheckboxChecked) {
      if(currentState is FilterLoaded) {
        final output = currentState.filters[event.filter.topic].map((filter) =>
        filter.name == event.filter.name ? event.filter : filter).toList();

        currentState.filters.update(event.filter.topic, (_) => output);

        yield FilterLoaded(filters: Map.from(currentState.filters));
      }
    }
  }
}
