import 'package:confs_tech/models/filters.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EventFilterState extends Equatable {
  EventFilterState();
}

class FilterLoading extends EventFilterState {
  @override
  List<Object> get props => [];
}

class FilterLoaded extends EventFilterState {
  final List<Filter> filters;

  FilterLoaded({ this.filters });

  @override
  List<Object> get props => [filters];
}

class FilterError extends EventFilterState {
  @override
  List<Object> get props => null;
}