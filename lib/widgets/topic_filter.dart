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

class _TopicFilterState extends State<TopicFilter>
    with AutomaticKeepAliveClientMixin<TopicFilter> {
  final String facetName;
  EventFilterBloc eventFilterBloc;

  _TopicFilterState(this.facetName);

  @override
  void initState() {
    eventFilterBloc = BlocProvider.of(context)..add(FetchFilters());
    super.initState();
  }

  @override
  void dispose() {
//    eventFilterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<EventFilterBloc, EventFilterState>(
      bloc: BlocProvider.of(context),
      builder: (BuildContext context, EventFilterState state) {
        if (state is FilterLoading) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          );
        } else if (state is FilterLoaded){
          List<Filter> countries = state.filters
              .where((filter) => filter.topic == facetName)
              .toList();
          return Container(
            width: double.maxFinite,
            child: ListView(
                children: countries.map((filter) =>
                    CheckboxListTile(
                      value: filter.checked,
                      title: Text('${filter.name} (${filter.count})'),
                      onChanged: (bool changed){
                        BlocProvider.of<EventFilterBloc>(context)
                            .add(SetFilterCheckboxChecked(
                            filter.copyWith(checked: changed))
                        );
                      },
                    )
                ).toList()
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}