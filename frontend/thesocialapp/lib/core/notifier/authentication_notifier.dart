import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thesocialapp/app_constants.dart';
import 'package:thesocialapp/core/api/authentication_api.dart';
import 'package:thesocialapp/core/services/cache_service.dart';
import 'package:thesocialapp/meta/views/home_view/home_view.dart';
import 'package:http/http.dart' as http;

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();
  final CacheService cacheService = CacheService();

  String _passwordLevel = "";
  String get passwordLevel => _passwordLevel;

  String _passwordEmoji = "";
  String get passwordEmoji => _passwordEmoji;

  void checkPasswordStrength({required String candidatePassword}) {
    String mediumPattern = r'^(?=(.*[!@#\$%^&\*~()\-__+.]){1,}).{7,}$';
    String strongPattern =
        r'^(?=(.*[a-z]){1,})(?=(.*[A-Z]){2,})(?=(.*[0-9]){1,})(?=(.*[!@#\$%^&\*~()\-__+.]){1,}).{7,}$';

    if (candidatePassword.contains(RegExp(strongPattern))) {
      _passwordLevel = kPasswordStrong;
      _passwordEmoji = kPassStrongEmoji;
      notifyListeners();
    } else if (candidatePassword.contains(RegExp(mediumPattern))) {
      _passwordLevel = kPasswordMedium;
      _passwordEmoji = kPassMediumEmoji;
      notifyListeners();
    } else if (!candidatePassword.contains(RegExp(mediumPattern))) {
      _passwordLevel = kPasswordWeek;
      _passwordEmoji = kPassWeekEmoji;
      notifyListeners();
    }
  }

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
      if (response.statusCode == kStatusCodeCreated) {
        cacheService.writeCache(key: "jwt", value: parsedValue['data']);
        Navigator.pushNamed(context, HomeView.routeName);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(parsedValue['message'])));
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
      if (response.statusCode == kStatusCodeOk) {
        cacheService.writeCache(key: "jwt", value: parsedValue['data']);
        Navigator.pushNamed(context, HomeView.routeName);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(parsedValue['message'])));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong\n" + error.toString())));
    }
  }

  Future decodeJwt({required dynamic token}) async {
    try {
      var response = await _authenticationAPI.decodeJwt(token: token);
      debugPrint(response.toString());
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> getUserEmailFromJwt({required BuildContext context}) async {
    var token = await cacheService.readCache(key: "jwt");
    final Map<String, dynamic> parsedTokenData =
        await jsonDecode(await decodeJwt(token: token));
    debugPrint(parsedTokenData['data'].toString());
    return parsedTokenData['data'];
  }
}
