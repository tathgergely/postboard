import 'package:flutter/material.dart';

class Notifier {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      BuildContext context, error) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(error.message!)));
  }
}
