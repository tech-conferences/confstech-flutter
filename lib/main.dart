import 'package:confs_tech/blocs/SimpleBlocDelegate.dart';
import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/blocs/event_blocs.dart';
import 'package:confs_tech/repositories/EventRepository.dart';
import 'package:confs_tech/repositories/filter_repository.dart';
import 'package:confs_tech/widgets/filter_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_page.dart';

void main() {
  final EventRepository eventRepository = EventRepository();
  final FilterRepository filterRepository = FilterRepository();

  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp(eventRepository, filterRepository));
}

class MyApp extends StatelessWidget {
  final EventRepository eventRepository;
  final FilterRepository filterRepository;

  MyApp(this.eventRepository, this.filterRepository);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
          create: (BuildContext context) => EventBloc(
            eventRepository: eventRepository,
          )..add(FetchEvent('', 0)),
          child: HomePage(),
        ),
        '/filter': (context) => BlocProvider(
          create: (BuildContext context) => EventFilterBloc(
            filterRepository: filterRepository
          )..add(FetchFilters()),
          child: MyTabbedPage(),
        )
      },
    );
  }
}

