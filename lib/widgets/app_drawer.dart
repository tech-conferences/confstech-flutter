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
            title: Text("Upcoming conferences"),
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
          ),
          ListTile(
            title: Text("Past conferences"),
            leading: Icon(Icons.event_available),
            onTap: (){
              BlocProvider.of<FilteredEventsBloc>(context)
                  .add(ShowPastChanged(showPast: true));
              Navigator.of(context).pop();
            },
          ),
//          AboutListTile(
//            icon: Icon(Icons.info),
//            applicationName: "Confs.tech",
//            applicationVersion: "1.0",
//            applicationLegalese: "© 2020 Leonardo Ferrari and contributors",
//          )
        ],
      ),
    );
  }
}