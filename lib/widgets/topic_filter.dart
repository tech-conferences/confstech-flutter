import 'package:confs_tech/blocs/bloc.dart';
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

class _TopicFilterState extends State<TopicFilter>
    with AutomaticKeepAliveClientMixin<TopicFilter> {
  final String facetName;

  _TopicFilterState(this.facetName);

  @override
  void initState() {
    BlocProvider.of<EventFilterBloc>(context)..add(FetchFilters(topic: facetName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<EventFilterBloc, EventFilterState>(
      bloc: BlocProvider.of(context),
      builder: (BuildContext context, EventFilterState state) {
        if (state is FilterLoading) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        } else if (state is FilterLoaded){
          return Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: state.filters.length,
              itemBuilder: (context, index){
                final filter = state.filters[index];
                return CheckboxListTile(
                  secondary: Icon(Icons.label_outline),
                  value: filter.checked,
                  title: Text('${filter.name} (${filter.count})'),
                  onChanged: (bool changed){
                    BlocProvider.of<EventFilterBloc>(context)
                        .add(SetFilterCheckboxChecked(filter, changed)
                    );
                  },
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}