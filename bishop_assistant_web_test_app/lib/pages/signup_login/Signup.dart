import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseDropDown.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/DarkPage.dart';
import 'package:flutter/material.dart';

///
/// Signup.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

// TODO: Add Firebase Input Possible
class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkPage(inputs: [
      InputField.floating(firstname),
      InputField.floating(lastname),
      InputField.floating(email),
      InputField.floating(phone),
      InputField.floating(password, isPassword: true),
      InputField.floating(confirmPassword, isPassword: true),
      FirebaseDropDown(
          collectionPath: Collections.roles, document: RolesDoc(), hint: role),
      InputField.floating(nameOfOrganization),
    ], buttons: [
      MyButton(label: signup, onPressed: () => Navigator.pop(context))
    ]);
  }
}
