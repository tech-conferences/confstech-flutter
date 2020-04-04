import 'package:confs_tech/blocs/event_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final EventBloc eventBloc = BlocProvider.of(context);

    return Form(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (text) {
                  eventBloc.add(FetchEvent(searchQuery: text));
                },
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Event name or location',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.close
                    ),
                    onPressed: (){
                     eventBloc.add(FetchEvent());
                     controller.clear();
                    },
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}