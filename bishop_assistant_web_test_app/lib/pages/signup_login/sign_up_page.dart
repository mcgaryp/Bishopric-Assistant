import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/dart_foundation.dart';

///
/// sign_up_page.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Key used to
  final _formKey = GlobalKey<FormState>();

  // TextEditingControllers
  TextEditingController fNameControl = TextEditingController();
  TextEditingController lNameControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmControl = TextEditingController();
  TextEditingController usernameControl = TextEditingController();

  // Format the number
  MaskTextInputFormatter filter = MaskTextInputFormatter(
      mask: "(###) ###-####", filter: {"#": RegExp(r'\d')});

  // Is the Widget waiting for a callback function to complete
  bool _isWaiting = false;

  @override
  void dispose() {
    super.dispose();
    fNameControl.dispose();
    lNameControl.dispose();
    emailControl.dispose();
    phoneControl.dispose();
    passwordControl.dispose();
    confirmControl.dispose();
    usernameControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DarkPage(showSpinner: _isWaiting, inputs: [
      Form(
        key: _formKey,
        child: Column(
          children: [
            InputField.floating(sFirstname,
                controller: fNameControl,
                validator: Validators.validateName,
                onSubmit: _onSubmit),
            InputField.floating(sLastname,
                controller: lNameControl,
                validator: Validators.validateName,
                onSubmit: _onSubmit),
            InputField.floating(sEmail,
                controller: emailControl,
                validator: Validators.validateEmail,
                onSubmit: _onSubmit),
            InputField.floating(sPhone,
                controller: phoneControl,
                formattingList: [filter],
                validator: Validators.standard,
                onSubmit: _onSubmit),
            InputField.floating(sUsername,
                controller: usernameControl,
                validator: Validators.standard,
                onSubmit: _onSubmit),
            InputField.floating(sPassword,
                isPassword: true,
                controller: passwordControl,
                validator: Validators.validatePassword,
                onSubmit: _onSubmit),
            InputField.floating(sConfirmPassword,
                isPassword: true,
                controller: confirmControl,
                validator: (str) => Validators.validateConfirmPassword(
                    str, passwordControl.text),
                onSubmit: _onSubmit),
          ],
        ),
      ),
    ], buttons: [
      AbsorbPointer(
        absorbing: _isWaiting,
        child: MyButton(label: sSignup, onPressed: _onPress),
      ),
      AbsorbPointer(
        absorbing: _isWaiting,
        child: MyButton(
            label: sLogin,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    ]);
  }

  /// Updates the isWaiting variable
  _setIsWaiting(bool val) {
    setState(() {
      _isWaiting = val;
    });
  }

  /// When the enter button is pressed
  void _onSubmit(String? string) => _onPress();

  /// When the button is pressed then
  void _onPress() async {
    // prevent the user from pressing the button more than once while backend thinks
    _setIsWaiting(true);

    // Verify information in form
    if (_formKey.currentState!.validate()) {
      // Password encryption
      String hashPassword =
          Crypt.sha256(passwordControl.text, salt: "bishopric").toString();

      try {
        FirebaseAccountRepository _accountRepo = FirebaseAccountRepository();

        DefaultCreateAccountUseCase createAccount =
            DefaultCreateAccountUseCase(_accountRepo);
        Name name = Name(first: fNameControl.text, last: lNameControl.text);
        Contact contact =
            Contact(phone: phoneControl.text, email: emailControl.text);
        Credentials credentials =
            Credentials(username: usernameControl.text, password: hashPassword);
        Result<Account> result = await createAccount.execute(
            name: name, contact: contact, credentials: credentials);
        if (result.isValue) _success(result.asValue!.value);
        if (result.isError) _error(result.asError!.error.toString());
      } catch (e) {
        _error(e.toString());
        if (kDebugMode) print(e.toString());
      }
    } else
      _setIsWaiting(false);
  }

  /// Should the process succeed
  void _success(Account account) {
    MyToast.toastSuccess("Welcome ${account.name.fullName}!");
    _setIsWaiting(false);
    Navigator.pop(context);
  }

  /// Should the process fail notify the user
  void _error(error) {
    MyToast.toastError(error);
    _setIsWaiting(false);
  }
}
