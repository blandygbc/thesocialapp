// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thesocialapp/app/routes/api_routes.dart';

class StoryAPI {
  final client = http.Client();

  Future storyAdd(
      {required String useremail, required List<String> story_assets}) async {
    final Uri uri = Uri.parse(APIRoutes.storyAddUrl + useremail);
    debugPrint(uri.toString());
    try {
      final http.Response response = await client.post(
        uri,
        body: json.encode({"story_assets": story_assets}),
        headers: APIRoutes.headers,
      );
      debugPrint("API Add post response ➡️ " + response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future storyFindAll() async {
    final Uri uri = Uri.parse(APIRoutes.storyFindAllUrl);
    debugPrint(uri.toString());
    try {
      final http.Response response = await client.get(
        uri,
        headers: APIRoutes.headers,
      );
      debugPrint("API FindAll stories response ➡️ " + response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future storyFindOne({required String story_id}) async {
    final Uri uri = Uri.parse(APIRoutes.storyFindOneUrl + story_id);
    debugPrint(uri.toString());
    try {
      final http.Response response = await client.get(
        uri,
        headers: APIRoutes.headers,
      );
      debugPrint("API FindAll stories response ➡️ " + response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future storyFindAllByUser({required String useremail}) async {
    final Uri uri = Uri.parse(APIRoutes.storyFindAllByUserUrl + useremail);
    debugPrint(uri.toString());
    try {
      final http.Response response = await client.get(
        uri,
        headers: APIRoutes.headers,
      );
      debugPrint("API FindAll stories response ➡️ " + response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future storyDelete({required String story_id}) async {
    final Uri uri = Uri.parse(APIRoutes.storyDeleteUrl + story_id);
    debugPrint(uri.toString());
    try {
      final http.Response response = await client.delete(
        uri,
        headers: APIRoutes.headers,
      );
      debugPrint("API FindAll stories response ➡️ " + response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
