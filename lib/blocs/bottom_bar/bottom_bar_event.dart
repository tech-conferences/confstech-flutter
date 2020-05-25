import 'package:equatable/equatable.dart';

abstract class BottomBarEvent extends Equatable {
  const BottomBarEvent();
}

class BottomBarSelected extends BottomBarEvent {
  final int selectedIndex;

  BottomBarSelected(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}