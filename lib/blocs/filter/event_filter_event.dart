import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EventFilterEvent extends Equatable {
  const EventFilterEvent();
}

class FetchFilters extends EventFilterEvent {
  final String topic;

  FetchFilters({ this.topic = '' });

  @override
  List<Object> get props => [];
}

class SetFilterCheckboxChecked extends EventFilterEvent {
  final Filter filter;
  final bool checked;

  SetFilterCheckboxChecked(this.filter, this.checked);

  @override
  List<Object> get props => [filter];
}

class ClearFiltersEvent extends EventFilterEvent{
  @override
  List<Object> get props => [];
}

class ApplyFilters extends EventFilterEvent {
  @override
  List<Object> get props => [];
}