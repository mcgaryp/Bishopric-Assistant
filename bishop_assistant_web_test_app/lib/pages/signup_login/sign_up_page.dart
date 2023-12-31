import 'package:the_assistant/firebase/repositories/repositories.dart';
import 'package:the_assistant/widgets/widgets.dart';
import 'package:crypt/crypt.dart';
import 'package:models/models/account.dart';

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

  // Is the Widget waiting for a callback function to complete
  bool _isWaiting = false;

  @override
  void initState() {
    if (kDebugMode) {
      fNameControl.text = "Developer";
      lNameControl.text = "Account One";
      emailControl.text = "teachrockstothink@gmail.com";
      phoneControl.text = "(479) 696-1637";
      passwordControl.text = "password1";
      confirmControl.text = "password1";
      usernameControl.text = "dev";
    }

    super.initState();
  }

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
                formattingList: [Validators.phoneFilter],
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
      Text(sReminderToVerifyEmail,
          textAlign: TextAlign.center, style: bodyLight),
      AbsorbPointer(
        absorbing: _isWaiting,
        child: MyButton(label: sSignup, onPressed: _onPress),
      ),
      AbsorbPointer(
        absorbing: _isWaiting,
        child: MyButton(
            label: sLogin,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, rLogin, ModalRoute.withName('/'));
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
        AccountRepository _accountRepo = FirestoreAccountRepository();
        DefaultCreateAccountUseCase createAccount =
            DefaultCreateAccountUseCase(_accountRepo);
        Name name = Name(first: fNameControl.text, last: lNameControl.text);
        Contact contact =
            Contact(phone: phoneControl.text, email: emailControl.text);
        Credentials credentials =
            Credentials(username: usernameControl.text, password: hashPassword);
        if (await createAccount.execute(
            name: name, contact: contact, credentials: credentials)) {
          _success(name);
        }
      } catch (e) {
        _error(e.toString());
        if (kDebugMode) print(e.toString());
      }
    } else {
      _setIsWaiting(false);
    }
  }

  /// Should the process succeed
  void _success(Name name) {
    MyToast.toastSuccess("Welcome ${name.fullName}!");
    _setIsWaiting(false);
    Navigator.pop(context);
  }

  /// Should the process fail notify the user
  void _error(error) {
    MyToast.toastError(error);
    _setIsWaiting(false);
  }
}
