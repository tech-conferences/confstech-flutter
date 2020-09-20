import 'package:confs_tech/bloc/feedback_page.dart';
import 'package:confs_tech/blocs/SimpleBlocDelegate.dart';
import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/repositories/feedback_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc/home_page.dart';

void main() {
  Bloc.observer = SimpleBlocDelegate();
  runApp(BlocProvider(
      create: (BuildContext context) => FilteredEventsBloc(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            primaryColor: Colors.orange,
            accentColor: Colors.lightBlue[400]),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/feedback': (context) => BlocProvider(
              create: (BuildContext context) => FeedbackBloc(
                  feedbackRepository:
                      FeedbackRepository(httpClient: http.Client())),
              child: FeedbackPage())
        });
  }
}
