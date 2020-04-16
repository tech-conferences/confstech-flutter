import 'package:confs_tech/blocs/filter_stats/bloc.dart';
import 'package:confs_tech/dialog/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: OutlineButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterDialog(
                        title: 'Filter by topics:',
                        facetName: 'topics',
                      );
                    }
                );
              },
              borderSide: BorderSide(width: .8, color: Colors.black45),
              child: BlocBuilder<FilterStatsBloc, FilterStatsState>(
                  bloc: BlocProvider.of(context),
                  builder: (BuildContext context, FilterStatsState state) {
                    return (state is FilterStatsLoaded && state.topicFilters > 0) ?
                    Text('Topic・${state.topicFilters}') :
                    Text('Topic', style: TextStyle(color: Colors.black87));
                  }
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: OutlineButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterDialog(
                        title: 'Filter by countries:',
                        facetName: 'country',
                      );
                    }
                );
              },
              borderSide: BorderSide(width: .8, color: Colors.black45),
              child: BlocBuilder<FilterStatsBloc, FilterStatsState>(
                  bloc: BlocProvider.of(context),
                  builder: (BuildContext context, FilterStatsState state) {
                    return (state is FilterStatsLoaded && state.countryFilters > 0) ?
                    Text('Country・${state.countryFilters}') :
                    Text('Country', style: TextStyle(color: Colors.black87));
                  }
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          )
        ],
      ),
    );
  }

}