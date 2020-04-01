import 'package:confs_tech/models/models.dart';
import 'package:equatable/equatable.dart';

class FilterList extends Equatable {

  final String topic;
  final List<Filter> filters;

  FilterList({this.topic, this.filters});

  @override
  List<Object> get props => [topic,  filters];

  FilterList copyWith({ String topic, List<Filter> filters }){
    return FilterList(
        topic: topic ?? this.topic,
        filters: filters ?? this.filters
    );
  }
}