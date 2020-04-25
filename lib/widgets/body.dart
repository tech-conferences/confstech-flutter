import 'package:confs_tech/blocs/event/event_bloc.dart';
import 'package:confs_tech/blocs/event/event_event.dart';
import 'package:confs_tech/blocs/event/event_state.dart';
import 'package:confs_tech/libs/grouped_list.dart';
import 'package:confs_tech/models/models.dart';
import 'package:confs_tech/widgets/conference_item.dart';
import 'package:confs_tech/widgets/country_header.dart';
import 'package:confs_tech/widgets/filter_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SearchBody extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  EventBloc _eventBloc;

  @override
  void initState() {
    super.initState();
    _eventBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _eventBloc.add(LoadMoreEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      bloc: BlocProvider.of(context),
      builder: (BuildContext context, EventState state){
        if(state is EventLoading){
          return Align(child: CircularProgressIndicator());
        }else if(state is EventEmpty){
          return Column(
            children: <Widget>[
              Text('No results :('),
            ],
          );
        }else if(state is EventLoaded){
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FilterHeader(),
                GroupedListView<Event, String>(
                    separator: Divider(),
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
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
                              _eventBloc.add(LoadMoreEvent());
                            },
                          ),
                        ),
                      ],
                    ),
                    itemBuilder: (BuildContext context, Event event) {
                      return ConferenceItem(
                        event: event,
                        showCallForPapers: state.showCallForPapers,
                      );
                    },
                    groupSeparatorBuilder: (value) {
                      return CountryHeader(value);
                    },
                    groupBy: (Event element) {
                      return DateFormat.yMMMM().format(DateTime.parse(element.startDate));
                    }),
              ],
            ),
          );
        }else if (state is EventError){
          return Center(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'An error has ocurred :(',
                      style: TextStyle(fontSize: 26),
                    ),
                    RaisedButton(
                      onPressed: (){
                        _eventBloc.add(FetchEvent());
                      },
                      child: Text('Try again'),
                    )
                  ],
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