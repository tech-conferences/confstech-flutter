import 'package:equatable/equatable.dart';

abstract class BottomBarState extends Equatable {
  final int selectedIndex;
  const BottomBarState({ this.selectedIndex = 0 });
}

class InitialBottomBarState extends BottomBarState {
  @override
  List<Object> get props => [];
}

class BottomBarSelectedSuccess extends BottomBarState {
  BottomBarSelectedSuccess({ selectedIndex = 0 })
      : super(selectedIndex: selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}