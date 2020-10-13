import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/dialog/filter_dialog.dart';
import 'package:confs_tech/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: BlocBuilder<FilterStatsBloc, FilterStatsState>(
                cubit: BlocProvider.of(context),
                builder: (BuildContext context, FilterStatsState state) {
                  return FilterButton(
                      selectedCount:
                          (state is FilterStatsLoaded) ? state.topicFilters : 0,
                      title: 'Topics',
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FilterDialog(
                                title: 'Filter by topics:',
                                facetName: 'topics',
                              );
                            });
                      });
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: BlocBuilder<FilterStatsBloc, FilterStatsState>(
                cubit: BlocProvider.of(context),
                builder: (BuildContext context, FilterStatsState state) {
                  return FilterButton(
                      selectedCount: (state is FilterStatsLoaded)
                          ? state.countryFilters
                          : 0,
                      title: 'Country',
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FilterDialog(
                                title: 'Filter by countries:',
                                facetName: 'country',
                              );
                            });
                      });
                }),
          )
        ],
      ),
    );
  }
}
