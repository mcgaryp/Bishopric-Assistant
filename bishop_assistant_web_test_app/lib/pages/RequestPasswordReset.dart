import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/DarkPage.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/InputField.dart';
import 'package:flutter/material.dart';

///
/// RequestPasswordReset.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class RequestPasswordReset extends StatelessWidget {
  const RequestPasswordReset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkPage(inputs: [
      InputField(hint: email + " or " + phone)
    ], buttons: [
      MyButton(
          label: requestReset,
          onPressed: () => Navigator.pushNamed(context, rPIN))
    ]);
  }
}
