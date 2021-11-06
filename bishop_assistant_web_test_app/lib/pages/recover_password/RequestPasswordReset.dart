import 'package:bishop_assistant_web_test_app/navigation/route_strings.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/my_button.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/DarkPage.dart';
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
      InputField.floating(email + " or " + phone)
    ], buttons: [
      MyButton(
          label: requestReset,
          onPressed: () => Navigator.pushNamed(context, rPIN))
    ]);
  }
}
