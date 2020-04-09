import 'package:confs_tech/blocs/SimpleBlocDelegate.dart';
import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/blocs/event_blocs.dart';
import 'package:confs_tech/blocs/filter_stats/bloc.dart';
import 'package:confs_tech/repositories/event_repository.dart';
import 'package:confs_tech/repositories/filter_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/filter_page.dart';
import 'bloc/home_page.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final EventFilterBloc _eventFilterBloc = EventFilterBloc(
      filterRepository: FilterRepository()
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext ctx) =>
                FilterStatsBloc(eventFilterBloc: _eventFilterBloc),
          ),
          BlocProvider(
              create: (BuildContext context) => _eventFilterBloc
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.orange,
              primaryColor: Colors.orange,
              accentColor: Colors.lightBlue[400]
            ),
            initialRoute: '/',
            routes: {
              '/': (context) =>
                  BlocProvider(
                    create: (BuildContext context) =>
                    EventBloc(
                        eventRepository: EventRepository(),
                        eventFilterBloc: _eventFilterBloc
                    )..add(FetchEvent()),
                    child: HomePage(),
                  ),
              '/filter': (context) => FilterPage(),
            }
        )
    );
  }
}

