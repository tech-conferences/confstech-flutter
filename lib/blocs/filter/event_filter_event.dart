import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EventFilterEvent extends Equatable {
  const EventFilterEvent();
}

class FetchFilters extends EventFilterEvent {
  final String topic;
  final bool showCallForPaper;
  final bool showPast;

  FetchFilters({ this.topic = '', this.showCallForPaper = false,
    this.showPast = false });

  @override
  List<Object> get props => [topic, showCallForPaper, showPast];
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
  final String facetName;

  ApplyFilters(this.facetName);

  @override
  List<Object> get props => [];
}