import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/widgets/filter_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<EventFilterBloc>(context).add(ClearFiltersEvent());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Filters'),
          ),
          body: MyTabbedPage()
      ),
    );
  }

}