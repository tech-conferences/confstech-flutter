import 'package:equatable/equatable.dart';

class Filter extends Equatable {

  final String key;
  final String name;
  final int count;
  final bool checked;
  final String topic;

  Filter({ this.key, this.name, this.count, this.checked, this.topic });

  @override
  List<Object> get props => [key, name, count, checked, topic];


  @override
  String toString() {
    return 'Filter{key: $key, name: $name, count: $count, checked: $checked, topic: $topic}';
  }

  Filter copyWith({String key, String name, int count, bool checked}){
    return Filter(
        key: key ?? this.key,
        name: name ?? this.name,
        count: count ?? this.count,
        checked: checked ?? this.checked,
        topic: this.topic
    );
  }
}