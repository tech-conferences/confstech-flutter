import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FeedbackEvent extends Equatable {}

class SendFeedbackEvent extends FeedbackEvent {
  final String title;
  final String comment;

  SendFeedbackEvent({ @required this.title, @required this.comment });

  @override
  List<Object> get props => [title, comment];
}