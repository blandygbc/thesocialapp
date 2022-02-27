// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thesocialapp/app/routes/api_routes.dart';
import 'package:thesocialapp/core/dto/post_dto.dart';

class PostAPI {
  final client = http.Client();

  Future addPost(PostDTO postDTO) async {
    final Uri uri = Uri.parse(APIRoutes.addPostUrl + postDTO.useremail);
    debugPrint(uri.toString());
    try {
      final http.Response response = await client.post(
        uri,
        body: postDTO.toJson(),
        headers: APIRoutes.headers,
      );
      debugPrint(response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
