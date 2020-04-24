import 'package:confs_tech/blocs/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBottomBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainBottomBarState();
  }
}

class _MainBottomBarState extends State<MainBottomBar> {
  int selectedIdx = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIdx,
      onTap: (int selected){
        switch (selected) {
          case 0:
            BlocProvider.of<FilteredEventsBloc>(context)
                .add(UpcomingSelected());
            setState(() {
              selectedIdx = 0;
            });
            break;
          case 1:
            BlocProvider.of<FilteredEventsBloc>(context)
                .add(CallForPaperSelected());
            setState(() {
              selectedIdx = 1;
            });
            break;
          case 2:
            BlocProvider.of<FilteredEventsBloc>(context)
                .add(ShowPastSelected());
            setState(() {
              selectedIdx = 2;
            });
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          title: Text("Upcoming"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_add),
          title: Text("Call for Papers"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_available),
          title: Text("Past"),
        )
      ],
    );
  }

}