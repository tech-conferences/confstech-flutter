import 'package:confs_tech/blocs/SimpleBlocDelegate.dart';
import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/blocs/filter_stats/bloc.dart';
import 'package:confs_tech/repositories/event_repository.dart';
import 'package:confs_tech/repositories/filter_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_page.dart';
import 'blocs/event/event_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            primaryColor: Colors.orange,
            accentColor: Colors.lightBlue[400]
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (BuildContext ctx) =>
                      FilterStatsBloc(
                          eventFilterBloc: EventFilterBloc(
                              filterRepository: FilterRepository()
                          )
                      )
              ),
              BlocProvider(
                  create: (BuildContext context) =>
                      EventBloc(
                          eventRepository: EventRepository()
                      )
              )
            ],
            child:HomePage(),
          )
        }
    );
  }
}

