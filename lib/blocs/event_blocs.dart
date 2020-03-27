import 'package:confs_tech/models/event_response.dart';
import 'package:confs_tech/models/events.dart';
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

  FetchEvent(this.searchQuery, this.page);

  @override
  List<Object> get props => [searchQuery, page];
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

  const EventLoaded({@required this.event, this.hasMore, this.currentQuery,
    this.currentPage})
      : assert(event != null);

  EventLoaded copyWith({
    List<Event> events,
    bool hasMore,
    String currentQuery,
    int currentPage,
  }) {
    return EventLoaded(
        event: events ?? this.event,
        hasMore: hasMore ?? this.hasMore,
        currentQuery: currentQuery ?? this.currentQuery,
        currentPage: currentPage ?? this.currentPage
    );
  }

  @override
  List<Object> get props => [event, hasMore, currentPage, currentQuery];

}

class EventError extends EventState {}

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;

  EventBloc({@required this.eventRepository}) : assert(eventRepository != null);

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
            .getEvents(event.searchQuery, event.page);

        if (response.events.length == 0) {
          yield EventEmpty();
        } else {
          yield EventLoaded(event: response.events, hasMore: response.hasMore,
              currentQuery: event.searchQuery, currentPage: response.page);
        }
      } catch (e) {
        print(e);
        yield EventError();
      }
    } else if (event is LoadMoreEvent && hasMore(currentState)) {
      try {
        if(currentState is EventLoaded) {
          EventResponse response = await this.eventRepository
              .getEvents(currentState.currentQuery, currentState.currentPage + 1);

          if (response.events.length == 0) {
            yield currentState.copyWith(hasMore: false);
          } else {
            yield currentState.copyWith(
              events: currentState.event + response.events,
              hasMore: response.hasMore,
              currentPage: currentState.currentPage + 1
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