import 'dart:async';

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
        List<Filter> filters = await this.filterRepository.fetchFilters(event.topic);

        yield FilterLoaded(filters: filters);
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
    }
  }
}
