import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedbackRepository {
  final http.Client httpClient;

  FeedbackRepository({ @required this.httpClient });

  Future<bool> sendFeedback(String title, String comment) async {
    try {
      final response = await httpClient
          .post('https://api.github.com/repos/leonardo2204/confstech-flutter/issues',
          headers: {
            'Accept': 'application/vnd.github.v3+json',
            'Authorization': 'token 8dc2921317294d332dff3b7294156ecf47309304'
          },
          body: jsonEncode({'title': title, 'body': comment}));

      return response.statusCode == 201;
    } catch(_) {
      return false;
    }
  }

}