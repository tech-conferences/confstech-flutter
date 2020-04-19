import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/repositories/filter_repository.dart';
import 'package:confs_tech/widgets/topic_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDialog extends StatefulWidget {
  final String facetName;
  final String title;

  FilterDialog({ @required this.facetName, @required this.title });

  @override
  State<StatefulWidget> createState() => _FilterDialogState(
    facetName: facetName,
    title: title,
  );
}

class _FilterDialogState extends State<FilterDialog> {
  final String facetName;
  final String title;
  EventFilterBloc _eventFilterBloc;

  _FilterDialogState({ @required this.facetName, @required this.title });

  @override
  void initState() {
    _eventFilterBloc = EventFilterBloc(
        filteredEventsBloc: BlocProvider.of<FilteredEventsBloc>(context),
        filterRepository: FilterRepository()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _eventFilterBloc,
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
                child: Text(this.title)
            ),
          ],
        ),
        content: TopicFilter(this.facetName),
        actions: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: FlatButton(
                        child: Text('Clear All'),
                        textColor: Theme.of(context).accentColor,
                        onPressed: () {
                          _eventFilterBloc.add(ClearFiltersEvent());
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Cancel'),
                      textColor: Theme.of(context).accentColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('Filter'),
                      textColor: Theme.of(context).accentColor,
                      onPressed: () {
                        _eventFilterBloc.add(ApplyFilters(this.facetName));
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}