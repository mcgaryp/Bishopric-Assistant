import 'package:bishop_assistant_web_test_app/repositories/firebase_account_repository.dart';
import 'package:bishop_assistant_web_test_app/util/route_strings.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/buttons/my_button.dart';
import 'package:bishop_assistant_web_test_app/widgets/inputs/input_field.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/dark_page.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/error_404_page.dart';
import 'package:flutter/material.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

///
/// ChangePassword.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _passwordControl = TextEditingController();
  TextEditingController _confirmControl = TextEditingController();
  bool _isWaiting = false;
  late AccountID id;

  @override
  Widget build(BuildContext context) {
    try {
      final Map args = ModalRoute.of(context)!.settings.arguments as Map;
      id = args["accountID"] as AccountID;
    } catch (e) {
      if (kDebugMode) print(e);
      return Error404Page();
    }

    return DarkPage(showSpinner: _isWaiting, inputs: [
      InputField.floating(
        sPassword,
        isPassword: true,
        controller: _passwordControl,
        onSubmit: _onSubmit,
        validator: Validators.validatePassword,
      ),
      InputField.floating(
        sConfirmPassword,
        isPassword: true,
        controller: _confirmControl,
        onSubmit: _onSubmit,
        validator: (str) =>
            Validators.validateConfirmPassword(_passwordControl.text, str),
      ),
    ], buttons: [
      AbsorbPointer(
        absorbing: _isWaiting,
        child: MyButton(
          label: sRequestReset,
          onPressed: _onPress,
        ),
      )
    ]);
  }

  void _onSubmit(String? str) => _onPress();

  void _onPress() async {
    _setIsWaiting(true);
    try {
      DefaultChangePasswordUseCase changePasswordUseCase =
          DefaultChangePasswordUseCase(FirebaseAccountRepository());
      Result<bool> result = await changePasswordUseCase.execute(
          accountID: id, password: _passwordControl.text);
      if (result.isError)
        _error(result.asError!.error);
      else
        _success();
    } catch (e) {
      _error(e);
      if (kDebugMode) print(e);
    }
    _setIsWaiting(false);
  }

  void _setIsWaiting(bool val) => setState(() => _isWaiting = val);

  void _error(msg) {
    MyToast.toastError(msg.toString());
  }

  void _success() {
    MyToast.toastSuccess("Password Change Successful");
    Navigator.pushReplacementNamed(context, rLogin);
  }
}
