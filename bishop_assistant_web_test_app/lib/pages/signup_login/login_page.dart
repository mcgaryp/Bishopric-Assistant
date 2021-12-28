import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';

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
            InputField.floating(sUsername,
                controller: usernameControl,
                onSubmit: _onSubmit,
                errorMsg: _errorMsg),
            // Password Field
            InputField.floating(
              sPassword,
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
            // Developer Quick Login
            if (kDebugMode)
              MyButton(
                  label: "Developer Quick Login", onPressed: _developerLogin),
            // Login Button
            MyButton(label: sLogin, onPressed: _onPress),
            // Sign Up Button
            MyButton(
                label: sSignup,
                onPressed: () => Navigator.pushNamed(context, rSignup)),
            // Forgot Password button
            // TODO: Add forgot button once the Mailer portion works for web
            // MyButton(
            //   label: forgot,
            //   onPressed: () => Navigator.pushNamed(context, rPasswordRequest),
            //   style: MyButtonStyle.text,
            // ),
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
      Account account = await authenticateAccount.execute(credentials);

      _success(account);
    } on InactiveAccountError catch (error) {
      Navigator.pushReplacementNamed(context, rReactivateAccount,
          arguments: error.id);
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

    // TODO: save a token to recognize the user is logged in still and refer to that
    // token to check fi they are logged in on page refresh

    // Change the session variable to logged in state
    final container = StateContainer.of(context);

    container.login(account);

    // check if the user has an organization or not
    OrganizationMember? org = await _accountHasOrganization();

    // Set the organization
    container.setOrganization(org);

    // Navigate to the home page
    Navigator.pushReplacementNamed(context, rHome);
  }

  void _developerLogin() {
    usernameControl.text = "dev";
    passwordControl.text = "password1";
    _onPress();
  }

  /// [_accountHasOrganization] checks to ensure that the user has an
  /// organization linked to the account returning true if so and false if not
  Future<OrganizationMember?> _accountHasOrganization() async {
    AccountID accountID = StateContainer.of(context).account.id;
    try {
      DefaultHasAssociatedOrganizationUseCase useCase =
          DefaultHasAssociatedOrganizationUseCase(FirebaseMemberRepository());
      OrganizationMember? org = await useCase.execute(accountID: accountID);
      return org;
    } catch (e) {
      if (kDebugMode) print(e);
    }

    return null;
  }
}
