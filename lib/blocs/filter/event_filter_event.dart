import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class EventFilterEvent extends Equatable {
  const EventFilterEvent();
}

class FetchFilters extends EventFilterEvent {
  @override
  List<Object> get props => [];
}

class SetFilterCheckboxChecked extends EventFilterEvent {
  final Filter filter;

  SetFilterCheckboxChecked(this.filter);

  @override
  List<Object> get props => [filter];
}

class AddNewFilters extends EventFilterEvent {
   final List<String> checkedFilters;

  AddNewFilters(this.checkedFilters);

  @override
  List<Object> get props => [checkedFilters];
}