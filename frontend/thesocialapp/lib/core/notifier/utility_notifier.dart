import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:thesocialapp/app/credentials/cloudinary_credentials.dart';
import 'package:thesocialapp/meta/utils/pick_image_util.dart';
import 'package:thesocialapp/meta/utils/snack_bar.dart';

class UtilityNotifier extends ChangeNotifier {
  String? _userImage = "";
  String? get userImage => _userImage;
  Future uploadUserImage({
    required BuildContext context,
  }) async {
    final _cloudnary = Cloudinary(CloudinaryCredentials.APIKEY,
        CloudinaryCredentials.APISecret, CloudinaryCredentials.APICloudName);
    try {
      final _image = await ImageUtility.getImage();
      await _cloudnary
          .uploadFile(
        filePath: _image!.path,
        resourceType: CloudinaryResourceType.image,
        folder: "theSocialApp",
      )
          .then((value) {
        _userImage = value.url;
        debugPrint(_userImage);
        notifyListeners();
        return _userImage;
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
