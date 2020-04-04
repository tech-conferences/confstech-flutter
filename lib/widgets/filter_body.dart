import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/widgets/topic_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({ Key key }) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Topic'),
    Tab(text: 'Country'),
  ];

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    BlocProvider.of<EventFilterBloc>(context).add(FetchFilters());
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void applyFilterAndClose(){
    BlocProvider.of<EventFilterBloc>(context).add(ApplyFiltersEvent());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          BlocProvider.of<EventFilterBloc>(context).add(ClearFiltersEvent());
          return true;
        },
        child : Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              BlocBuilder<FilterStatsBloc, FilterStatsState>(
                bloc: BlocProvider.of(context),
                builder: (BuildContext context, FilterStatsState state) {
                  return IconButton(
                      icon: Icon(Icons.check),
                      onPressed: (state is FilterStatsLoaded
                          && state.selectedFilters > 0) ?
                          () => applyFilterAndClose(): null
                  );
                },
              )
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: myTabs,
            ),
            title: Text('Filter'),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              TopicFilter('topics'),
              TopicFilter('country'),
            ],
          ),
        )
    );
  }
}