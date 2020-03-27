import 'package:equatable/equatable.dart';

class Event extends Equatable {

  final int id;
  final String uuid;
  final String name;
  final String url;
  final String city;
  final String country;
  final String startDate;
  final String endDate;
  final String twitter;
  final List<dynamic> topics;

  Event({this.id, this.uuid, this.name, this.url, this.city, this.country,
      this.startDate, this.endDate, this.twitter, this.topics});

  @override
  List<Object> get props => [id];


  @override
  String toString() {
    return 'Event{id: $id, uuid: $uuid, name: $name, url: $url, city: $city,'
        ' country: $country, startDate: $startDate, endDate: $endDate, '
        'twitter: $twitter}';
  }

  static Event fromJson(dynamic json){
    return Event(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      twitter: json['twitter'] as String,
      topics: json['topics'] as List<dynamic>
    );
  }

}