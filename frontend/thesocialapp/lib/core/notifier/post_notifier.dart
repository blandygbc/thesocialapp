// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocialapp/core/api/add_post_api.dart';
import 'package:http/http.dart' as http;
import 'package:thesocialapp/core/notifier/authentication_notifier.dart';

class PostNotifier extends ChangeNotifier {
  final PostAPI _postAPI = PostAPI();

  Future addPost({
    required BuildContext context,
    required String post_title,
    required String post_text,
    String? post_images,
  }) async {
    try {
      final authenticationNotifier = Provider.of<AuthenticationNotifier>(
        context,
        listen: false,
      );
      final String useremail =
          await authenticationNotifier.getUserEmailFromJwt(context: context);
      debugPrint("Post email $useremail");
      http.Response response = await _postAPI.addPost(
        post_title: post_title,
        post_text: post_text,
        useremail: useremail,
      );
      debugPrint(response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
