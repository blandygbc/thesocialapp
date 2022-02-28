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
    try {
      final http.Response response = await client.post(
        uri,
        body: jsonEncode({
          "username": username,
          "useremail": useremail,
          "userpassword": userpassword,
          "userimage": userimage,
        }),
        headers: APIRoutes.headers,
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future login({
    required String email,
    required String password,
  }) async {
    final Uri uri = Uri.parse(APIRoutes.loginURL);
    debugPrint(uri.toString());
    try {
      final http.Response response = await client.post(
        uri,
        body: jsonEncode({"useremail": email, "userpassword": password}),
        headers: APIRoutes.headers,
      );
      debugPrint("Retornou o login");
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future decodeJwt({required dynamic token}) async {
    final Uri uri = Uri.parse(APIRoutes.decodeJwtUrl);
    debugPrint(uri.toString());
    Map<String, String> headers = APIRoutes.headers;
    headers["Authorization"] = token;
    try {
      final http.Response response = await client.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == kStatusCodeOk) {
        debugPrint(response.body);
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
