import 'dart:async';

import 'package:bloc/bloc.dart';

import '../bloc.dart';


class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  @override
  BottomBarState get initialState => InitialBottomBarState();

  @override
  Stream<BottomBarState> mapEventToState(
    BottomBarEvent event,
  ) async* {
    if (event is BottomBarSelected) {
      yield BottomBarSelectedSuccess(selectedIndex: event.selectedIndex);
    }
  }
}
