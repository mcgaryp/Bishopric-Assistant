import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

///
/// EditProfile.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/18/21
/// Copyright 2021 Po. All rights reserved.
///

class EditProfile extends StatefulWidget {
  final void Function() onSave;

  const EditProfile(this.onSave, {Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();

  bool _isWaiting = false;

  late Account account;

  @override
  void dispose() {
    super.dispose();
    passwordControl.dispose();
    confirmPasswordControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    account = StateContainer.of(context).account;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          AbsorbPointer(
            absorbing: _isWaiting,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputField.border(account.contact.email),
                  InputField.border(account.contact.phone),
                  InputField.floating(
                    sPassword,
                    isPassword: true,
                    controller: passwordControl,
                    validator: Validators.validatePassword,
                    onSubmit: _onSave,
                    //errorMsg: _errorMsg
                  ),
                  InputField.floating(
                    sConfirmPassword,
                    isPassword: true,
                    controller: confirmPasswordControl,
                    validator: (text) => Validators.validateConfirmPassword(
                        text, passwordControl.text),
                    //errorMsg: _errorMsg,
                    onSubmit: _onSave,
                  ), //add
                  MyButton(label: sSave, onPressed: _onPress),
                  Padding(
                    padding: const EdgeInsets.only(top: padding16),
                    child: CardButton(sCancel, onPressed: widget.onSave),
                  )
                ],
              ),
            ),
          ),
        ]);
  }

  void _onSave(String? str) => _onPress();

  Future _onPress() async {
    _setIsWaiting(true);

    // Verify information in form
    if (_formKey.currentState!.validate()) {
      String hashPassword =
          Crypt.sha256(passwordControl.text, salt: "bishopric").toString();
      try {
        // Get encrypted Password from database
        FirebaseAccountRepository _accountRepository =
            FirebaseAccountRepository();
        DefaultChangePasswordUseCase newPassword =
            DefaultChangePasswordUseCase(_accountRepository);

        Result<bool> result = await newPassword.execute(
            accountID: account.id, password: hashPassword);

        if (result.isError) {
          _error(result.asError!.error.toString());
          // Turn off the spinner
          _setIsWaiting(false);
          return;
        }
        MyToast.toastSuccess("Password Updated Successfully");
      } catch (e) {
        _error(e.toString());
        if (kDebugMode) print(e.toString());
        _setIsWaiting(false);
        return;
      }

      widget.onSave();
    }
    // Turn off the spinner
    _setIsWaiting(false);
  }

  void _setIsWaiting(bool val) {
    setState(() {
      _isWaiting = val;
    });
  }

  void _error(String error) {
    // Set the error message
    //_errorMsg = "Username or Password Incorrect";
    MyToast.toastError(error);
  }
}
