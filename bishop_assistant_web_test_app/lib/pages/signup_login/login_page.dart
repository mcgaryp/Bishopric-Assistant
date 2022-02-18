import 'package:bishop_assistant_web_test_app/state/firebase_authentication.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:crypt/crypt.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/exceptions.dart';

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
  bool _canRequestEmailVerification = false;
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
            // TODO: Uncomment
            // MyButton(
            //   label: sForgot,
            //   onPressed: () => Navigator.pushNamed(context, rPasswordRequest),
            //   style: MyButtonStyle.text,
            // ),
            // Request email verification
            if (_canRequestEmailVerification)
              MyButton(
                label: sRequestToVerifyEmail,
                onPressed: () =>
                    FirebaseAuthentication.user.sendEmailVerification(),
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
      // Password encryption
      String hashPassword =
          Crypt.sha256(passwordControl.text, salt: "bishopric").toString();

      Credentials credentials =
          Credentials(password: hashPassword, username: usernameControl.text);

      await StateContainer.of(context).login(credentials);

      _success();
    } on InactiveAccountError catch (error) {
      Navigator.pushReplacementNamed(context, rReactivateAccount,
          arguments: error.id);
    } on VerifyEmailError catch (e) {
      _errorMsg = null;
      setState(() => _canRequestEmailVerification = true);
      MyToast.toastError(e);
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

  void _success() async {
    _errorMsg = null;

    // TODO: save a token to recognize the user is logged in still and refer to that token to check if they are logged in on page refresh

    // Navigate to the home page
    Navigator.pushReplacementNamed(context, rHome);
  }

  void _developerLogin() {
    usernameControl.text = "dev";
    passwordControl.text = "password1";
    _onPress();
  }
}
