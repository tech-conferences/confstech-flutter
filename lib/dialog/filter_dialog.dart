import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/widgets/topic_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDialog extends StatelessWidget{
  final String facetName;
  final String title;
  final VoidCallback onClearAllPressed;

  FilterDialog({ @required this.facetName, @required this.title, @required this.onClearAllPressed });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
              child: Text(this.title)
          ),
          OutlineButton(
            onPressed: this.onClearAllPressed,
            child: Text('Clear all'),
          )
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
            BlocProvider.of<EventFilterBloc>(context).add(ApplyFiltersEvent());
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}