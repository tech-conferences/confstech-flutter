// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/models/event_response.dart';
import 'package:confs_tech/models/models.dart';
import 'package:confs_tech/repositories/event_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('EventBloc', () {
    EventBloc eventBloc;
    EventRepository mockEventRepository;
    FilteredEventsBloc mockFilteredEventsBloc;
    setUp(() {
      mockEventRepository = MockEventRepository();
      mockFilteredEventsBloc = MockFilteredEventsBloc();

      eventBloc = EventBloc(
        eventRepository: mockEventRepository,
        filteredEventsBloc: mockFilteredEventsBloc,
      );
    });

    tearDown(() {
      eventBloc?.close();
      mockFilteredEventsBloc?.close();
    });

    test('initial state is EventLoading', () {
      whenListen(mockFilteredEventsBloc, Stream.value(FilteredEventsLoading()));
      expect(eventBloc.state, EventLoading());
    });

    blocTest(
      'emits [EventLoading, EventEmpty] when FetchEvent returns empty',
      build: () {
        whenListen(
            mockFilteredEventsBloc, Stream.value(FilteredEventsLoaded()));
        when(mockEventRepository.getEvents(any, any, any, any, any))
            .thenAnswer((realInvocation) async => EventResponse(events: []));

        return eventBloc;
      },
      act: (EventBloc bloc) => bloc.add(FetchEvent()),
      expect: [EventLoading(), EventEmpty()],
    );

    blocTest(
      'emits [EventLoading, EventLoaded] when FetchEvent returns not empty',
      build: () {
        whenListen(
            mockFilteredEventsBloc, Stream.value(FilteredEventsLoaded()));
        when(mockEventRepository.getEvents(any, any, any, any, any)).thenAnswer(
            (realInvocation) async => EventResponse(events: [event]));

        return eventBloc;
      },
      act: (EventBloc bloc) => bloc.add(FetchEvent()),
      expect: [
        EventLoading(),
        EventLoaded(
            event: [event],
            showPast: false,
            showCallForPapers: false,
            currentQuery: '')
      ],
    );
  });
}

class MockFilteredEventsBloc extends MockBloc<FilteredEventsState>
    implements FilteredEventsBloc {}

class MockEventRepository extends Mock implements EventRepository {}

var event = Event(id: 123);
