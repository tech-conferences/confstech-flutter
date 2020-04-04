import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:confs_tech/blocs/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class FilterStatsBloc extends Bloc<FilterStatsEvent, FilterStatsState> {
  final EventFilterBloc eventFilterBloc;
  StreamSubscription eventSubscription;

  FilterStatsBloc({ @required this.eventFilterBloc }){
    eventSubscription = eventFilterBloc.listen((state){
      if (state is FilterApplied || state is FilterLoaded){
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
      int selectedFilters = event.filters.where((event) => event.checked)
          .toList().length;

      yield FilterStatsLoaded(selectedFilters);
    }
  }

  @override
  Future<void> close() {
    eventSubscription.cancel();
    return super.close();
  }

}
