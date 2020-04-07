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

  _TopicFilterState(this.facetName);

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      state.selectedFilters.isNotEmpty ?
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                              child: Text(
                                'Selected filters',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Wrap(
                                children: state.selectedFilters.map((selected) =>
                                    Padding(padding: const EdgeInsets.all(6.0),
                                      child: InputChip(
                                        label: Text(selected.name),
                                        onDeleted: () {
                                          BlocProvider.of<EventFilterBloc>(context)
                                              .add(SetFilterCheckboxChecked(
                                              selected.copyWith(checked: false)
                                          ));
                                        },
                                      ),
                                    )
                                ).toList()),
                            Divider(thickness: 1.2),
                          ]) : Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Wrap(
                            children: countries.map((filter) =>
                                Card(
                                  child: ListTile(
                                    title: Text('${filter.name} (${filter.count})'),
                                    onTap: (){
                                      BlocProvider.of<EventFilterBloc>(context)
                                          .add(SetFilterCheckboxChecked(
                                          filter.copyWith(checked: true))
                                      );
                                    },
                                  ),
                                )
                            ).toList()
                        ),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}