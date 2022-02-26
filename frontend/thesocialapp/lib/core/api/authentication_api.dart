import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thesocialapp/app/routes/api_routes.dart';
import 'package:thesocialapp/app_constants.dart';

class AuthenticationAPI {
  final client = http.Client();

  Future signUp({
    required String username,
    required String useremail,
    required String userpassword,
    required String userimage,
  }) async {
    final Uri uri = Uri.parse(APIRoutes.signupUrl);
    debugPrint(uri.toString());
    final http.Response response = await client.post(uri,
        body: jsonEncode({
          "username": username,
          "useremail": useremail,
          "userpassword": userpassword,
          "userimage": userimage,
        }),
        headers: {
          'content-type': 'application/json;unicode=UTF-8',
          'Accept': 'application/json',
          "Access-Control-Allow-Origin": "*",
        });
    if (response.statusCode == statusCodeCreated) {
      return response.body;
    }
  }

  Future login({
    required String email,
    required String password,
  }) async {
    final Uri uri = Uri.parse(APIRoutes.loginURL);
    debugPrint(uri.toString());
    final http.Response response = await client.post(uri,
        body: jsonEncode({"useremail": email, "userpassword": password}),
        headers: {
          'content-type': 'application/json;unicode=UTF-8',
          'Accept': 'application/json',
          "Access-Control-Allow-Origin": "*",
        });
    if (response.statusCode == statusCodeCreated) {
      debugPrint(response.body);
      return response.body;
    }
  }
}
