import 'package:meta/meta.dart';

@immutable
abstract class FeedbackState {}

class InitialFeedbackState extends FeedbackState {}

class SendingFeedbackState extends FeedbackState {}

class FeedbackSuccessState extends FeedbackState {}

class FeedbackFailureState extends FeedbackState {}