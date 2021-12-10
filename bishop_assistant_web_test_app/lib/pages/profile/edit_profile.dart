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

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _editProfile();
  }
}

class _editProfile extends StatefulWidget {
  const _editProfile({Key? key}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<_editProfile> {
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
    return LightPage(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            MemberIcon(Icons.person, size: 65),
            Text(account.name.fullName, style: titleDark),
            if (StateContainer.of(context).isMember)
              Text(StateContainer.of(context).member.role.anonymous,
                  style: subheadDark),
            MyConstrainedBox300(children: [
              MyDivider(color: dark),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding8),
                child: AbsorbPointer(
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
                          validator: (text) =>
                              Validators.validateConfirmPassword(
                                  text, passwordControl.text),
                          //errorMsg: _errorMsg,
                          onSubmit: _onSave,
                        ), //add validator
                        MyButton(label: sSave, onPressed: _onPress)
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ]),
    );
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

      Navigator.pushReplacementNamed(context, rProfile);
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
