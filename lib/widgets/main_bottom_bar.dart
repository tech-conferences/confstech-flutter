import 'package:confs_tech/blocs/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainBottomBarState();
  }
}

class _MainBottomBarState extends State<MainBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarBloc, BottomBarState>(
      cubit: BlocProvider.of(context),
      builder: (context, state) => BottomNavigationBar(
        currentIndex: state.selectedIndex,
        onTap: (int selected) {
          switch (selected) {
            case 0:
              BlocProvider.of<BottomBarBloc>(context).add(BottomBarSelected(0));
              BlocProvider.of<FilteredEventsBloc>(context)
                  .add(UpcomingSelected());
              break;
            case 1:
              BlocProvider.of<BottomBarBloc>(context).add(BottomBarSelected(1));
              BlocProvider.of<FilteredEventsBloc>(context)
                  .add(CallForPaperSelected());
              break;
            case 2:
              BlocProvider.of<BottomBarBloc>(context).add(BottomBarSelected(2));
              BlocProvider.of<FilteredEventsBloc>(context)
                  .add(ShowPastSelected());
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
      ),
    );
  }
}
