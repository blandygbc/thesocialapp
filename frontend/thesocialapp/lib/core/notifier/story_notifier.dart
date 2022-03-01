// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocialapp/app/credentials/cloudinary_credentials.dart';
import 'package:thesocialapp/core/api/story_api.dart';
import 'package:thesocialapp/core/notifier/authentication_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:thesocialapp/meta/utils/pick_image_util.dart';
import 'package:thesocialapp/meta/utils/snack_bar.dart';

class StoryNotifier extends ChangeNotifier {
  final StoryAPI storyAPI = StoryAPI();

  File? _selectedStoryAsset;
  File? get selectedStoryAsset => _selectedStoryAsset;

  String? _uploadedImageurl;
  String? get uploadedImageurl => _uploadedImageurl;

  Future storyAdd({
    required BuildContext context,
    required List<String> story_assets,
  }) async {
    try {
      final authenticationNotifier =
          Provider.of<AuthenticationNotifier>(context, listen: false);
      String useremail =
          await authenticationNotifier.getUserEmailFromJwt(context: context);
      final http.Response response = await storyAPI.storyAdd(
          useremail: useremail, story_assets: story_assets);
      debugPrint("Notifier Story Add response ➡️ " + response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future storyFindAll() async {
    try {
      final http.Response response = await storyAPI.storyFindAll();
      debugPrint("Notifier Story FindALl response ➡️ " + response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future storyFindOne({required String story_id}) async {
    try {
      final http.Response response =
          await storyAPI.storyFindOne(story_id: story_id);
      debugPrint("Notifier Story FindALl response ➡️ " + response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future storyFindAllByUser({required String useremail}) async {
    try {
      final http.Response response =
          await storyAPI.storyFindAllByUser(useremail: useremail);
      debugPrint("Notifier Story FindALl response ➡️ " + response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future storyDelete({required String story_id}) async {
    try {
      final http.Response response =
          await storyAPI.storyDelete(story_id: story_id);
      debugPrint("Notifier Story FindALl response ➡️ " + response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future storyPickAssets() async {
    final _image = await ImageUtility.getImage();
    if (_image != null) {
      _selectedStoryAsset = File(_image.path);
      notifyListeners();
      return File(_image.path);
    }
  }

  void storyRemoveAssets() async {
    _selectedStoryAsset = null;
    notifyListeners();
  }

  Future storyUploadAssets({
    required BuildContext context,
  }) async {
    final _cloudnary = Cloudinary(CloudinaryCredentials.APIKEY,
        CloudinaryCredentials.APISecret, CloudinaryCredentials.APICloudName);
    try {
      await _cloudnary
          .uploadFile(
        filePath: _selectedStoryAsset!.path,
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
