// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:thesocialapp/app/credentials/cloudinary_credentials.dart';
import 'package:thesocialapp/app_constants.dart';
import 'package:thesocialapp/core/api/post_api.dart';
import 'package:http/http.dart' as http;
import 'package:thesocialapp/core/dto/post_dto.dart';
import 'package:thesocialapp/core/model/post_model.dart';
import 'package:thesocialapp/meta/utils/pick_image_util.dart';
import 'package:thesocialapp/meta/utils/snack_bar.dart';

class PostNotifier extends ChangeNotifier {
  final PostAPI _postAPI = PostAPI();

  File? _selectedPostImage;
  File? get selectedPostImage => _selectedPostImage;

  String? _uploadedImageurl;
  String? get uploadedImageurl => _uploadedImageurl;

  Future addPost({
    required BuildContext context,
    required PostDTO postDTO,
  }) async {
    try {
      http.Response response = await _postAPI.addPost(postDTO);
      debugPrint("Notifier Add post response ➡️ " + response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future fetchPosts({
    required BuildContext context,
  }) async {
    try {
      http.Response response = await _postAPI.fechPost();
      if (response.statusCode == kStatusCodeOk) {
        final List<PostData> postdata = Post.fromJson(response.body).data;
        return postdata;
      } else {
        final Map<String, dynamic> parsedValue = json.decode(response.body);
        if (parsedValue['message'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            parsedValue['message'],
          )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            response.body,
          )));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  pickPostImage() async {
    final _image = await ImageUtility.getImage();
    if (_image != null) {
      _selectedPostImage = File(_image.path);
      notifyListeners();
    }
  }

  removeImage() {
    _selectedPostImage = null;
    notifyListeners();
  }

  Future uploadPostImage({
    required BuildContext context,
  }) async {
    final _cloudnary = Cloudinary(CloudinaryCredentials.APIKEY,
        CloudinaryCredentials.APISecret, CloudinaryCredentials.APICloudName);
    try {
      await _cloudnary
          .uploadFile(
        filePath: _selectedPostImage!.path,
        resourceType: CloudinaryResourceType.image,
        folder: "theSocialApp",
      )
          .then((value) {
        debugPrint(value.url);
        _uploadedImageurl = value.url;
        notifyListeners();
        return _uploadedImageurl;
      });
    } catch (error) {
      debugPrint(error.toString());
      SnackBarUtility.showSnackBar(
        message: error.toString(),
        context: context,
      );
    }
  }
}
