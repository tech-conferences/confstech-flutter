import 'package:equatable/equatable.dart';

class Filter extends Equatable {

  final String name;
  final int count;
  final bool checked;
  final String topic;

  Filter({ this.name, this.count, this.checked, this.topic });

  @override
  List<Object> get props => [name, count, checked, topic];

  @override
  String toString() {
    return 'Filter{name: $name, count: $count, checked: $checked, topic: $topic}';
  }

  Filter copyWith({String name, int count, bool checked}){
    return Filter(
        name: name ?? this.name,
        count: count ?? this.count,
        checked: checked ?? this.checked,
        topic: topic ?? this.topic
    );
  }
}