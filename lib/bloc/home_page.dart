import 'dart:math' as math;

import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/blocs/event/event_bloc.dart';
import 'package:confs_tech/blocs/event/event_event.dart';
import 'package:confs_tech/repositories/event_repository.dart';
import 'package:confs_tech/widgets/app_drawer.dart';
import 'package:confs_tech/widgets/body.dart';
import 'package:confs_tech/widgets/filter_header.dart';
import 'package:confs_tech/widgets/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EventBloc _eventBloc;

  @override
  void initState() {
    _eventBloc = EventBloc(
        filteredEventsBloc: BlocProvider.of(context),
        eventRepository: EventRepository()
    )..add(FetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext ctx) => _eventBloc
            ),
            BlocProvider(
              create: (BuildContext ctx) =>
                  FilterStatsBloc(
                      filteredEventsBloc: BlocProvider.of<FilteredEventsBloc>(context)
                  ),
            ),],
          child: CustomScrollView(
            slivers: <Widget>[
              SliverSearchBar(
                onSearchTextChanged: (text) {
                  BlocProvider.of<FilteredEventsBloc>(context)
                      .add(SearchChanged(searchQuery: text));
                },
              ),
              SliverPersistentHeader(
                delegate: new _SliverAppBarDelegate(
                    minHeight: kToolbarHeight,
                    maxHeight: kToolbarHeight + 48,
                    child: FilterHeader()
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                    SearchBody(),
                  ])
              )
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}