import 'package:confs_tech/blocs/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text("Confs.Tech"),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor
            ),
          ),
          ListTile(
            title: Text("Upcoming events"),
            leading: Icon(Icons.event),
            onTap: (){
              BlocProvider.of<FilteredEventsBloc>(context)
                  .add(CallForPaperChanged(showCallForPapers: false));
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text("Call for Papers"),
            leading: Icon(Icons.note_add),
            onTap: (){
              BlocProvider.of<FilteredEventsBloc>(context)
                  .add(CallForPaperChanged(showCallForPapers: true));
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}