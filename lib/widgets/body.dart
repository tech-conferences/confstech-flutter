import 'package:confs_tech/blocs/event/event_bloc.dart';
import 'package:confs_tech/blocs/event/event_event.dart';
import 'package:confs_tech/blocs/event/event_state.dart';
import 'package:confs_tech/libs/grouped_list.dart';
import 'package:confs_tech/models/models.dart';
import 'package:confs_tech/widgets/conference_item.dart';
import 'package:confs_tech/widgets/country_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SearchBody extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final scrollController = ScrollController();
  final scrollThreshold = 200.0;
  EventBloc eventBloc;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
    eventBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (maxScroll - currentScroll <= scrollThreshold) {
      eventBloc.add(LoadMoreEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      bloc: BlocProvider.of(context),
      builder: (BuildContext context, EventState state){
        if(state is EventLoading){
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Align(
                child: CircularProgressIndicator()
            ),
          );
        }else if(state is EventEmpty){
          return Column(
            children: <Widget>[
              Text('No results :('),
            ],
          );
        }else if(state is EventLoaded){
          return GroupedListView<Event, String>(
              separator: Divider(),
              shrinkWrap: true,
              elements: state.event,
              hasFooter: state.hasMore,
              renderFooter: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 12),
                    child: RaisedButton(
                      child: Text('Load More...'),
                      onPressed: (){
                        eventBloc.add(LoadMoreEvent());
                      },
                    ),
                  ),
                ],
              ),
              indexedItemBuilder: (BuildContext context, Event event, int index) {
                return ConferenceItem(event: event);
              },
              groupSeparatorBuilder: (value) {
                return CountryHeader(value);
              },
              groupBy: (Event element) {
                return DateFormat.yMMMM().format(DateTime.parse(element.startDate));
              });
        }else if (state is EventError){
          return Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'An error has ocurred :(',
                        style: TextStyle(fontSize: 26),
                      ),
                      RaisedButton(
                        onPressed: (){
                          eventBloc.add(FetchEvent());
                        },
                        child: Text('Try again'),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}