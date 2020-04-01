import 'package:confs_tech/blocs/event_blocs.dart';
import 'package:confs_tech/widgets/body.dart';
import 'package:confs_tech/widgets/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverSearchBar(
              onSearchTextChanged: (text) {
                BlocProvider.of<EventBloc>(context).add(FetchEvent(text, 0));
              },
//              actions: <Widget>[
//                IconButton(
//                  icon: Icon(Icons.filter_list),
//                  onPressed: () {
//                    Navigator.pushNamed(context, '/filter');
//                  },
//                )
//              ],
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SearchBody(),
                      ),
                    ],
                  )
                ])
            )
          ],
        ),
      ),
    );
  }
}
