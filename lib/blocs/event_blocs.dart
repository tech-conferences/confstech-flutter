import 'dart:async';

import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/models/event_response.dart';
import 'package:confs_tech/models/events.dart';
import 'package:confs_tech/models/models.dart';
import 'package:confs_tech/repositories/EventRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();
}

class FetchEvent extends EventEvent {
  final String searchQuery;
  final int page;
  final List<Filter> filters;

  FetchEvent({ this.searchQuery = '', this.page = 0, this.filters = const []});

  @override
  List<Object> get props => [searchQuery, page, filters];
}

class LoadMoreEvent extends EventEvent {
  @override
  List<Object> get props => [];
}

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventEmpty extends EventState {}

class EventUninitialized extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> event;
  final bool hasMore;
  final currentQuery;
  final currentPage;
  final List<Filter> selectedFilters;

  const EventLoaded({@required this.event, this.hasMore, this.currentQuery,
    this.currentPage, this.selectedFilters})
      : assert(event != null);

  EventLoaded copyWith({
    List<Event> events,
    bool hasMore,
    String currentQuery,
    int currentPage,
    List<Filter> selectedFilters,
  }) {
    return EventLoaded(
        event: events ?? this.event,
        hasMore: hasMore ?? this.hasMore,
        currentQuery: currentQuery ?? this.currentQuery,
        currentPage: currentPage ?? this.currentPage,
        selectedFilters: selectedFilters ?? this.selectedFilters
    );
  }

  @override
  List<Object> get props => [event, hasMore, currentPage, currentQuery];
}

class EventError extends EventState {}

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;
  final EventFilterBloc eventFilterBloc;
  StreamSubscription eventFilterSubscription;

  EventBloc({@required this.eventRepository, @required this.eventFilterBloc}){
    eventFilterSubscription = eventFilterBloc.listen((state){
      if(state is FilterApplied){
        add(FetchEvent(filters: state.selectedFilters));
      }
    });
  }

  @override
  Future<void> close() {
    eventFilterSubscription.cancel();
    return super.close();
  }

  @override
  Stream<EventState> transformEvents(Stream<EventEvent> events,
      Stream<EventState> Function(EventEvent) next) {
    return events
        .debounceTime(Duration(milliseconds: 300))
        .switchMap(next);
  }

  EventState get initialState => EventUninitialized();

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    final currentState = state;

    if (event is FetchEvent) {
      try {
        yield EventLoading();
        EventResponse response = await this.eventRepository
            .getEvents(event.searchQuery, event.page, event.filters);

        if (response.events.length == 0) {
          yield EventEmpty();
        } else {
          yield EventLoaded(event: response.events, hasMore: response.hasMore,
              currentQuery: event.searchQuery, currentPage: response.page,
              selectedFilters: response.selectedFilters);
        }
      } catch (e) {
        print(e);
        yield EventError();
      }
    } else if (event is LoadMoreEvent && hasMore(currentState)) {
      try {
        if(currentState is EventLoaded) {
          EventResponse response = await this.eventRepository
              .getEvents(currentState.currentQuery, currentState.currentPage + 1,
              currentState.selectedFilters);

          if (response.events.length == 0) {
            yield currentState.copyWith(hasMore: false);
          } else {
            yield currentState.copyWith(
              events: currentState.event + response.events,
              hasMore: response.hasMore,
              currentPage: currentState.currentPage + 1,
              selectedFilters: currentState.selectedFilters,
            );
          }
        }
      }catch(e) {
        print(e);
        yield EventError();
      }
    }
  }

  bool hasMore(EventState state) {
    return state is EventLoaded && state.hasMore;
  }
}