import 'package:flutter/material.dart';

class SnackBarUtility {
  static showSnackBar({
    required String message,
    required BuildContext context,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
