import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';

enum MessageType { success, error, info, warning }

extension ShowSnackbar on BuildContext {
  void showToast({required String? message, required MessageType messageType}) {
    /*Fluttertoast.showToast(
        msg: "This is a Toast message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );*/

    Color backgroundColor = natural5;

    switch (messageType) {
      case MessageType.success:
        backgroundColor = success;
        break;
      case MessageType.error:
        backgroundColor = error;
        break;
      case MessageType.info:
        backgroundColor = secondary;
        break;
      case MessageType.warning:
        backgroundColor = warning;
        break;
    }

    Fluttertoast.showToast(
        msg: message ?? "مشکلی پیش آمده است.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);

/*    var snackBar = SnackBar(
      content: Text(message ?? "مشکلی روی داده است."),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var scaffold = ScaffoldMessenger.of(this);
      scaffold.hideCurrentSnackBar();
      scaffold.showSnackBar(snackBar);
    });*/
  }
}
