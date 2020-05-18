import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedbackRepository {
  final http.Client httpClient;

  FeedbackRepository({ @required this.httpClient });

  Future<bool> sendFeedback(String title, String comment) async {
    try {
      const GH_TOKEN = String.fromEnvironment('GH_TOKEN');
      final response = await httpClient
          .post('https://api.github.com/repos/leonardo2204/confstech-flutter/issues',
          headers: {
            'Accept': 'application/vnd.github.v3+json',
            'Authorization': 'token $GH_TOKEN'
          },
          body: jsonEncode({'title': title, 'body': comment}));

      return response.statusCode == 201;
    } catch(_) {
      return false;
    }
  }

}