import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/widgets/topic_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({ Key key }) : super(key: key);
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Topic'),
    Tab(text: 'Country'),
  ];

  @override
  void initState() {
    BlocProvider.of<EventFilterBloc>(context).add(FetchFilters());
    super.initState();
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
        child : DefaultTabController(
          length: myTabs.length,
          child: Scaffold(
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
                tabs: myTabs,
              ),
              title: Text('Filter'),
            ),
            body: TabBarView(
              children: [
                TopicFilter('topics'),
                TopicFilter('country'),
              ],
            ),
          ),
        )
    );
  }
}