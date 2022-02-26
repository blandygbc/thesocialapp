import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thesocialapp/core/services/cache_service.dart';

class ImageUtility {
  static Future<File?> getImage() async {
    final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return _image != null ? File(_image.path) : null;
  }

  static Future<File> saveImageToDeviceStorage(
      {required File image, required String name}) async {
    // getting a directory path for saving
    final Directory path = await getApplicationDocumentsDirectory();

    // copy the file to a new path
    final File localImage = await image.copy(path.toString() + '/$name');

    return localImage;
  }

  static Future<bool> saveImageToPreferences(String key, String value) async {
    /* final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value); */
    final cache = CacheService();
    return await cache.writeCache(key: key, value: value);
  }

  static Future<String> getImageFromPreferences(String key) async {
/*     final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) as Future<String>; */
    final cache = CacheService();
    return await cache.readCache(key: key);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String), fit: BoxFit.fill);
  }
}
