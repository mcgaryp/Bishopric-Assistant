import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/DarkPage.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseDropDown.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/InputField.dart';
import 'package:flutter/material.dart';

///
/// Signup.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkPage(inputs: [
      InputField(hint: firstname),
      InputField(hint: lastname),
      InputField(hint: email),
      InputField(hint: phone),
      InputField(hint: password),
      InputField(hint: confirmPassword),
      FirebaseDropDown(
          collectionPath: Collections.roles, document: RolesDoc(), hint: role),
      InputField(hint: nameOfOrganization),
    ], buttons: [
      MyButton(label: signup, onPressed: () => Navigator.pop(context))
    ]);
  }
}
