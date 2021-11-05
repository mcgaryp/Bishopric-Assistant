import 'package:bishop_assistant_web_test_app/navigation/route_strings.dart';
import 'package:bishop_assistant_web_test_app/repositories/firebase_account_repository.dart';
import 'package:bishop_assistant_web_test_app/util/MyToast.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/DarkPage.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:models/models/account.dart';
import 'package:models/models/account_domain/account_use_cases/login_use_case.dart';
import 'package:models/shared/repository.dart';

///
/// login_page.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Key used to
  final _formKey = GlobalKey<FormState>();

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
      Form(
        key: _formKey,
        child: Column(
          children: [
            InputField.floating(username,
                controller: usernameControl,
                onSubmit: _onSubmit,
                errorMsg: _errorMsg),
            // Password Field
            InputField.floating(
              password,
              isPassword: true,
              controller: passwordControl,
              errorMsg: _errorMsg,
              onSubmit: _onSubmit,
            ),
          ],
        ),
      ),
    ], buttons: [
      // Prevent the user from clicking one to many times
      AbsorbPointer(
        absorbing: _isWaiting,
        child: Column(
          children: [
            // Login Button
            MyButton(label: login, onPressed: _onPress),
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

  void _onSubmit(String? string) => _onPress();

  // Validate the password and let the user know if there is an incorrect
  // username or password
  Future _onPress() async {
    // Change the state to is waiting
    _setIsWaiting(true);

    try {
      // Get encrypted Password from database
      FirebaseAccountRepository _accountRepository =
          FirebaseAccountRepository();
      DefaultAuthenticateAccountUseCase authenticateAccount =
          DefaultAuthenticateAccountUseCase(_accountRepository);

      // Password encryption
      String hashPassword =
          Crypt.sha256(passwordControl.text, salt: "bishopric").toString();

      Credentials credentials =
          Credentials(password: hashPassword, username: usernameControl.text);
      Result<Account> result = await authenticateAccount.execute(credentials);

      if (result.isError) _error(result.asError!.error.toString());
      if (result.isValue) _success(result.asValue!.value);
    } catch (e) {
      _error(e.toString());
      if (kDebugMode) print(e.toString());
    }
    // Turn off the spinner
    _setIsWaiting(false);
  }

  // Set the private variable isWaiting
  void _setIsWaiting(bool val) {
    setState(() {
      _isWaiting = val;
    });
  }

  void _error(String error) {
    // Set the error message
    _errorMsg = "Username or Password Incorrect";
    MyToast.toastError(error);
  }

  void _success(Account account) async {
    _errorMsg = "";

    try {
      FirebaseAccountRepository _repository = FirebaseAccountRepository();
      DefaultLoginUseCase login = DefaultLoginUseCase(_repository);
      Result<bool> result = await login.execute(account);
      if (result.isError) {
        MyToast.toastError(result.asError!.error.toString());
        return;
      }
    } catch (e) {
      MyToast.toastError(e.toString());
      if (kDebugMode) print(e);
      return;
    }

    Navigator.pushReplacementNamed(context, rHome);
  }
}
