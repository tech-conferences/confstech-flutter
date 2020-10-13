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
  final String cfpEndDate;
  final String cfpUrl;

  Event(
      {this.id,
      this.uuid,
      this.name,
      this.url,
      this.city,
      this.country,
      this.startDate,
      this.endDate,
      this.twitter,
      this.topics,
      this.cfpEndDate,
      this.cfpUrl});

  @override
  List<Object> get props => [id];

  static Event fromJson(dynamic json) {
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
      topics: json['topics'] as List<dynamic>,
      cfpEndDate: json['cfpEndDate'] as String,
      cfpUrl: json['cfpUrl'] as String,
    );
  }

  @override
  bool get stringify => true;
}
