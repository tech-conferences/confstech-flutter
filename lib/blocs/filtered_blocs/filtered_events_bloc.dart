import 'dart:async';

import 'package:bloc/bloc.dart';

import '../bloc.dart';

class FilteredEventsBloc extends Bloc<FilteredBlocsEvent, FilteredEventsState> {
  FilteredEventsBloc();

  @override
  FilteredEventsState get initialState => FilteredEventsLoading();

  @override
  Stream<FilteredEventsState> mapEventToState(
    FilteredBlocsEvent event,
  ) async* {
    if (event is FilterUpdated) {
      yield FilteredEventsLoaded(selectedFilters: event.selectedFilter);
    }
  }
}
