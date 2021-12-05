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
            InputField.floating(firstname,
                controller: fNameControl,
                validator: _verifyName,
                onSubmit: _onSubmit),
            InputField.floating(lastname,
                controller: lNameControl,
                validator: _verifyName,
                onSubmit: _onSubmit),
            InputField.floating(email,
                controller: emailControl,
                validator: _verifyEmail,
                onSubmit: _onSubmit),
            InputField.floating(phone,
                controller: phoneControl,
                formattingList: [filter],
                validator: Validators.standard,
                onSubmit: _onSubmit),
            InputField.floating(username,
                controller: usernameControl,
                validator: Validators.standard,
                onSubmit: _onSubmit),
            InputField.floating(password,
                isPassword: true,
                controller: passwordControl,
                validator: _password,
                onSubmit: _onSubmit),
            InputField.floating(confirmPassword,
                isPassword: true,
                controller: confirmControl,
                validator: _confirmPassword,
                onSubmit: _onSubmit),
          ],
        ),
      ),
    ], buttons: [
      AbsorbPointer(
        absorbing: _isWaiting,
        child: MyButton(label: signup, onPressed: _onPress),
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

  /// Verify Names
  /// - Names do not have a limit to how many letters are in them
  /// - Names do not have whitespace at the end or start of them
  /// - Name should start with a capital letter
  String? _verifyName(String? text) {
    String? returnValue = Validators.standard(text);

    if (text != null) {
      RegExp regExp = RegExp(
        r"\d",
        caseSensitive: false,
        multiLine: false,
      );

      if (regExp.hasMatch(text)) returnValue = "Names cannot contain numbers";
    }

    return returnValue;
  }

  /// Verify email
  /// - Emails must have an @
  /// - Emails must have something before the @
  /// - Emails must have something after the @ along with a . following that
  /// - Emails must have something after the .
  /// Send a verification email on create
  String? _verifyEmail(String? text) {
    String? returnValue = Validators.standard(text);

    if (text != null) {
      RegExp regExp = RegExp(
        r"\w+@\w+\.\w+",
        caseSensitive: false,
        multiLine: false,
      );

      if (!regExp.hasMatch(text))
        returnValue = "Please enter valid email address";
    }

    return returnValue;
  }

  /// Password Validation
  /// - Must be at least 8 characters
  /// - Must have at least one number
  /// - Must have at least one symbol
  String? _password(String? text) {
    String? returnValue = Validators.standard(text);

    if (text != null) {
      RegExp minimum = RegExp(
        r".{8,}",
        caseSensitive: false,
        multiLine: false,
      );
      RegExp number = RegExp(
        r"\d+",
        caseSensitive: false,
        multiLine: false,
      );

      if (!minimum.hasMatch(text))
        return "Passwords must use at least 8 characters";

      if (!number.hasMatch(text)) return "Passwords must use at least 1 number";
    }

    return returnValue;
  }

  /// Verify Confirming Password
  /// - Standard
  /// - Must match password text
  String? _confirmPassword(String? text) {
    String? returnValue = Validators.standard(text);

    if (text != null) if (text != passwordControl.text)
      return "Passwords do not match";

    return returnValue;
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
        if (result.isValue) _successEnd(result.asValue!.value);
        if (result.isError) _error(result.asError!.error.toString());
      } catch (e) {
        _error(e.toString());
        if (kDebugMode) print(e.toString());
      }
    } else
      _setIsWaiting(false);
  }

  /// Should the process succeed
  void _successEnd(Account account) {
    MyToast.toastSuccess("Welcome ${account.name.name}!");
    _setIsWaiting(false);
    Navigator.pop(context);
  }

  /// Should the process fail notify the user
  void _error(error) {
    MyToast.toastError(error);
    _setIsWaiting(false);
  }
}
