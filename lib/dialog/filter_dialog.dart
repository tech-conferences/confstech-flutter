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
        actions: <Widget>[
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
              _eventFilterBloc.add(ApplyFilters());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}