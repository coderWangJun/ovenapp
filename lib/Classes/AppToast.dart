import 'package:flutter/material.dart' show Colors;
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast, Toast, ToastGravity;

class AppToast {

  static void showToast(String info,[len=1]) {
    Fluttertoast.showToast(
        msg: info,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: len,
        backgroundColor: Colors.black,
        textColor: Colors.grey,
        fontSize: 16.0);
  }

}
