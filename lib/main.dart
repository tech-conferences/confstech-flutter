import 'package:confs_tech/blocs/SimpleBlocDelegate.dart';
import 'package:confs_tech/blocs/event_blocs.dart';
import 'package:confs_tech/repositories/EventRepository.dart';
import 'package:confs_tech/widgets/body.dart';
import 'package:confs_tech/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  final EventRepository eventRepository = EventRepository();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(BlocProvider(
    create: (BuildContext context) => EventBloc(
        eventRepository: eventRepository
    )..add(FetchEvent('', 0)
    ),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confs.tech"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {

            },
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Search(),
            SearchBody()
          ],
        ),
      ),
    );
  }
}
