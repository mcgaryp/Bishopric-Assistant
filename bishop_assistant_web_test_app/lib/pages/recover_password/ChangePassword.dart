import 'package:bishop_assistant_web_test_app/navigation/route_strings.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/my_button.dart';
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
      InputField.floating(password, isPassword: true),
      InputField.floating(confirmPassword, isPassword: true),
    ], buttons: [
      MyButton(
          label: requestReset,
          onPressed: () => Navigator.pushReplacementNamed(context, rLogin)),
    ]);
  }
}
