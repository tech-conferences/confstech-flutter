import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:confs_tech/repositories/feedback_repository.dart';
import 'package:flutter/material.dart';

import '../bloc.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedbackRepository feedbackRepository;

  FeedbackBloc({@required this.feedbackRepository})
      : super(InitialFeedbackState());

  @override
  Stream<FeedbackState> mapEventToState(
    FeedbackEvent event,
  ) async* {
    final currentState = state;

    if (event is SendFeedbackEvent) {
      try {
        yield SendingFeedbackState();
        final bool response = await this
            .feedbackRepository
            .sendFeedback(event.title, event.comment);

        if (response) {
          yield FeedbackSuccessState();
        } else {
          yield FeedbackFailureState();
        }
      } catch (_) {
        yield FeedbackFailureState();
      }
    }
  }
}
