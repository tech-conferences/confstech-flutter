import 'package:confs_tech/blocs/event_blocs.dart';
import 'package:confs_tech/widgets/bottom_loader.dart';
import 'package:confs_tech/widgets/conference_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return CircularProgressIndicator();
        }else if(state is EventEmpty){
          return Text('No results :(');
        }else if(state is EventLoaded){
          return Expanded(child:
          ListView.builder(
              controller: scrollController,
              itemCount: state.hasMore ? state.event.length + 1 : state.event.length,
              itemBuilder: (BuildContext context, int index) {
                if(index >= state.event.length){
                  return BottomLoader();
                } else {
                  return ConferenceItem(event: state.event[index]);
                }
              })
          );
        }else{
          return Container();
        }
      },
    );
  }
}