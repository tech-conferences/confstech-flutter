import 'package:confs_tech/blocs/bloc.dart';
import 'package:confs_tech/blocs/event/event_bloc.dart';
import 'package:confs_tech/blocs/event/event_event.dart';
import 'package:confs_tech/dialog/about_dialog.dart' as ConfsAboutDialog;
import 'package:confs_tech/repositories/event_repository.dart';
import 'package:confs_tech/widgets/body.dart';
import 'package:confs_tech/widgets/main_bottom_bar.dart';
import 'package:confs_tech/widgets/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EventBloc _eventBloc;

  @override
  void initState() {
    _eventBloc = EventBloc(
        filteredEventsBloc: BlocProvider.of(context),
        eventRepository: EventRepository()
    )..add(FetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomBarBloc(),
      child: Scaffold(
        appBar: SearchBar(
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (context){
                return {'Feedback', 'Share the app', 'About'}.map((item) =>
                    PopupMenuItem(
                      value: item,
                      child: Text(item),
                    )
                ).toList();
              },
              onSelected: (selected) {
                if (selected == 'Feedback') {
                  Navigator.pushNamed(context, '/feedback');
                } else if (selected == 'About') {
                  showAboutDialog(
                      context: context,
                      applicationName: "Confs.tech",
                      applicationIcon: Image(
                        image: AssetImage("images/logo_icon.png"),
                        width: 32,
                        height: 32,
                      ),
                      applicationVersion: "1.0",
                      children: [
                        ConfsAboutDialog.AboutDialog()
                      ]
                  );
                } else if (selected == 'Share the app') {
                  //CHANGE THE URL TO iOS and Android!!!
                  Share.share('Hey, check out this conference events app: '
                      'https://play.google.com/store/apps/details?id=leonardo2204.com.confs_tech');
                }
              },
            )
          ],
          onSearchTextChanged: (text) {
            BlocProvider.of<FilteredEventsBloc>(context)
                .add(SearchChanged(searchQuery: text));
          },
        ),
        body: SafeArea(
          child:  MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (BuildContext ctx) => _eventBloc
              ),
              BlocProvider(
                create: (BuildContext ctx) =>
                    FilterStatsBloc(
                        filteredEventsBloc: BlocProvider.of<FilteredEventsBloc>(context)
                    ),
              ),
            ],
            child: SearchBody(),
          ),
        ),
        bottomNavigationBar: MainBottomBar(),
      ),
    );
  }
}