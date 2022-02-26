import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thesocialapp/app_constants.dart';
import 'package:thesocialapp/core/api/authentication_api.dart';
import 'package:thesocialapp/core/api/services/cache_service.dart';
import 'package:thesocialapp/meta/views/home_view/home_view.dart';
import 'package:http/http.dart' as http;

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();
  final CacheService cacheService = CacheService();
  Future signUp({
    required BuildContext context,
    required String username,
    required String useremail,
    required String userpassword,
    required String userimage,
  }) async {
    try {
      final http.Response response = await _authenticationAPI.signUp(
        username: username,
        useremail: useremail,
        userpassword: userpassword,
        userimage: userimage,
      );
      final Map<String, dynamic> parsedValue = await json.decode(response.body);
      if (response.statusCode == statusCodeCreated) {
        cacheService.writeCache(key: "jwt", value: parsedValue['data']);
        Navigator.pushNamed(context, HomeView.routeName);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(parsedValue['data'])));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something went wrong:\n" + error.toString())));
    }
  }

  Future login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final http.Response response = await _authenticationAPI.login(
        email: email,
        password: password,
      );
      final Map<String, dynamic> parsedValue = await json.decode(response.body);
      if (response.statusCode == statusCodeCreated) {
        cacheService.writeCache(key: "jwt", value: parsedValue['data']);
        Navigator.pushNamed(context, HomeView.routeName);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(parsedValue['data'])));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong\n" + error.toString())));
    }
  }
}
