import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:confs_tech/blocs/bloc.dart';
import 'package:flutter/material.dart';

class FilterStatsBloc extends Bloc<FilterStatsEvent, FilterStatsState> {
  final FilteredEventsBloc filteredEventsBloc;
  StreamSubscription eventSubscription;

  FilterStatsBloc({ @required this.filteredEventsBloc }){
    eventSubscription = filteredEventsBloc.listen((state){
      if (state is FilteredEventsLoaded){
        add(UpdateStats(state.selectedFilters));
      }
    });
  }

  @override
  FilterStatsState get initialState => FilterStatsLoading();

  @override
  Stream<FilterStatsState> mapEventToState(
      FilterStatsEvent event,
      ) async* {
    if (event is UpdateStats) {
      int topicFilter = event.filters.where((event) =>
        event.checked && event.topic == 'topics').toList().length;

      int countryFilter = event.filters.where((event) =>
        event.checked && event.topic == 'country').toList().length;

      yield FilterStatsLoaded(selectedFilters: topicFilter + countryFilter,
          topicFilters: topicFilter, countryFilters: countryFilter);
    }
  }

  @override
  Future<void> close() {
    eventSubscription.cancel();
    return super.close();
  }

}
