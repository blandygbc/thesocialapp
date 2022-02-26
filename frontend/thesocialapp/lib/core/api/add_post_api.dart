// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thesocialapp/app/routes/api_routes.dart';

class PostAPI {
  final client = http.Client();

  Future addPost({
    required String post_title,
    required String post_text,
    String? post_images,
    required String useremail,
  }) async {
    final Uri uri = Uri.parse(APIRoutes.addPostUrl + useremail);
    debugPrint(uri.toString());
    try {
      final http.Response response = await client.post(
        uri,
        body: jsonEncode({
          "post_title": post_title,
          "post_text": post_text,
          "post_images": post_images,
        }),
        headers: APIRoutes.headers,
      );
      debugPrint(response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
