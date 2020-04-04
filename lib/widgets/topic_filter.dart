import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicFilter extends StatefulWidget {
  final String facetName;

  TopicFilter(this.facetName);

  @override
  State<StatefulWidget> createState() {
    return _TopicFilterState(facetName);
  }
}

class _TopicFilterState extends State<TopicFilter> {
  final String facetName;

  _TopicFilterState(this.facetName);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<EventFilterBloc, EventFilterState>(
              bloc: BlocProvider.of(context),
              builder: (BuildContext context, EventFilterState state) {
                if (state is FilterLoading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is FilterLoaded){
                  List<Filter> countries = state.filters
                      .where((filter) => filter.topic == facetName)
                      .toList();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Wrap(
                          children: countries.map((filter) =>
                              Card(
                                child: CheckboxListTile(
                                  title: Text('${filter.name} (${filter.count})'),
                                  value: filter.checked,
                                  onChanged: (bool checked){
                                    BlocProvider.of<EventFilterBloc>(context)
                                        .add(SetFilterCheckboxChecked(
                                        filter.copyWith(checked: checked))
                                    );
                                  },
                                ),
                              )
                          ).toList()
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}