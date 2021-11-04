import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
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
      // Username Field
      InputField.floating(username,
          controller: usernameControl, errorMsg: _errorMsg),
      // Password Field
      InputField.floating(password,
          isPassword: true, controller: passwordControl, errorMsg: _errorMsg),
    ], buttons: [
      // Prevent the user from clicking one to many times
      AbsorbPointer(
        absorbing: _isWaiting,
        child: Column(
          children: [
            // Login Button
            MyButton(label: login, onPressed: _validatePassword),
            // Sign Up Button
            MyButton(
                label: signup,
                onPressed: () => Navigator.pushNamed(context, rSignup)),
            // Forgot Password button
            MyButton(
              label: forgot,
              onPressed: () => Navigator.pushNamed(context, rPasswordRequest),
              style: MyButtonStyle.text,
            ),
          ],
        ),
      )
    ]);
  }

  // Validate the password and let the user know if there is an incorrect username or password
  Future<void> _validatePassword() async {
    // Change the state to is waiting
    _setIsWaiting(true);

    // incorrect password or user function
    void incorrect() {
      // Set the error message
      _errorMsg = "Username or Password Incorrect";
      // Switch off the spinner
      _setIsWaiting(false);
    }

    // Get encrypted Password from database
    Member? member = await OldFirestoreHelper.findMember(usernameControl.text);

    // Member username not found
    if (member == null) {
      incorrect();
      return; // Exit the function
    }

    // Get the hashed password
    final String hashPassword = member.password;

    // Convert to normal
    final h = Crypt(hashPassword);

    // Password is incorrect
    if (!h.match(passwordControl.text)) {
      incorrect();
      return;
    }

    // Proceed to the login page
    Navigator.pushReplacementNamed(context, rHome);

    // Turn off the spinner
    _setIsWaiting(false);
  }

  // Set the private variable isWaiting
  _setIsWaiting(bool val) {
    setState(() {
      _isWaiting = val;
    });
  }
}
