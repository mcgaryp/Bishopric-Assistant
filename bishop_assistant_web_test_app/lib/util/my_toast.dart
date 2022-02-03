import 'package:fluttertoast/fluttertoast.dart';

///
/// MyToast.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/22/21
/// Copyright 2021 Po. All rights reserved.
///

class MyToast {
  static void toastError(dynamic msg) => Fluttertoast.showToast(
      msg: msg.toString(),
      webBgColor: "linear-gradient(to right, #e36359, #a62c2b)",
      timeInSecForIosWeb: 5);

  static void toastSuccess(String msg) =>
      Fluttertoast.showToast(msg: msg, timeInSecForIosWeb: 5);
}
