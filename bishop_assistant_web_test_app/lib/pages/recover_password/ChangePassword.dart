import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/DarkPage.dart';
import 'package:flutter/material.dart';

///
/// ChangePassword.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkPage(inputs: [
      InputField(password, isPassword: true),
      InputField(confirmPassword, isPassword: true),
    ], buttons: [
      MyButton(
          label: requestReset,
          onPressed: () => Navigator.pushReplacementNamed(context, rLogin)),
    ]);
  }
}
