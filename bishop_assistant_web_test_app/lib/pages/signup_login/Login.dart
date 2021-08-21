import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/DarkPage.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';

///
/// Login.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController passwordControl = TextEditingController();
  final TextEditingController usernameControl = TextEditingController();

  bool _isWaiting = false;
  String? _errorMsg;

  @override
  void dispose() {
    super.dispose();
    passwordControl.dispose();
    usernameControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DarkPage(showSpinner: _isWaiting, inputs: [
      InputField.floating(username, controller: usernameControl, errorMsg: _errorMsg),
      InputField.floating(password,
          isPassword: true, controller: passwordControl, errorMsg: _errorMsg),
    ], buttons: [
      // TODO: Create session with successful login before moving on to the home page
      MyButton(label: login, onPressed: _validatePassword),
      MyButton(
          label: signup,
          onPressed: () => Navigator.pushNamed(context, rSignup)),
      MyButton(
        label: forgot,
        onPressed: () => Navigator.pushNamed(context, rPasswordRequest),
        style: MyButtonStyle.text,
      )
    ]);
  }

  // Validate the password and let the user know if there is an incorrect username or password
  Future<void> _validatePassword() async {
    // Get encrypted Password from database
    _setIsWaiting(true);
    Member? member = await FirestoreHelper.findMember(usernameControl.text);

    // Member username not found
    if (member == null) {
      _errorMsg = "Username or Password Incorrect";
      _setIsWaiting(false);
      return;
    }

    final String hashString = member.password;

    // Convert to normal
    final h = Crypt(hashString);

    // Password is incorrect
    if (!h.match(passwordControl.text)) {
      _errorMsg = "Username or Password Incorrect";
      _setIsWaiting(false);
      return;
    }

    // TODO: Create session of member information

    // Turn off the spinner
    _setIsWaiting(false);

    // Proceed to the login page
    Navigator.pushReplacementNamed(context, rHome);
  }

  // Set the private variable isWaiting
  _setIsWaiting(bool val) {
    setState(() {
      _isWaiting = val;
    });
  }
}
