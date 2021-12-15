import 'package:bishop_assistant_web_test_app/repositories/firebase_account_repository.dart';
import 'package:bishop_assistant_web_test_app/util/my_toast.dart';
import 'package:bishop_assistant_web_test_app/util/route_strings.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/buttons/my_button.dart';
import 'package:bishop_assistant_web_test_app/widgets/inputs/input_field.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/dark_page.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

///
/// RequestPasswordReset.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// TODO: Comments
class RequestPasswordReset extends StatefulWidget {
  const RequestPasswordReset({Key? key}) : super(key: key);

  @override
  State<RequestPasswordReset> createState() => _RequestPasswordResetState();
}

class _RequestPasswordResetState extends State<RequestPasswordReset> {
  // Key used to
  final _formKey = GlobalKey<FormState>();

  bool _isWaiting = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DarkPage(showSpinner: _isWaiting, inputs: [
      Form(
          key: _formKey,
          child: InputField.floating("$sUsername or $sEmail or $sPhone",
              controller: controller, onSubmit: _onSubmit))
    ], buttons: [
      AbsorbPointer(
          absorbing: _isWaiting,
          child: MyButton(label: sRequestReset, onPressed: _onPress))
    ]);
  }

  // Set the private variable isWaiting
  void _setIsWaiting(bool val) {
    setState(() {
      _isWaiting = val;
    });
  }

  void _onSubmit(String? string) => _onPress();

  void _onPress() async {
    _setIsWaiting(true);

    try {
      DefaultRecoverAccountUseCase recoverAccountUseCase =
          DefaultRecoverAccountUseCase(FirebaseAccountRepository());

      Contact contact = await recoverAccountUseCase.execute(controller.text);
      await _sendEmail(contact);
    } catch (error) {
      MyToast.toastError(error.toString());
    }
    _setIsWaiting(false);
  }

  Future<void> _sendEmail(Contact contact) async {
    //TODO: Remove
    Pin pin = Pin();

    String email = "noreply@bishopric-assistant.web.app";
    // TODO: Store username and password secretly...
    String username = ''; // TODO: Get from sendinblue
    String password = ''; // TODO: Get from sendinblue
    try {
      final smtpServer = SmtpServer(
        'smtp-relay.sendinblue.com',
        username: username,
        password: password,
        port: 587,
      );

      // Create random pin
      // Pin pin = Pin();

      // TODO: Finish Message creation
      final Message message = Message()
        ..from = Address(email, "Bishopric Assistant")
        ..recipients = [contact.email]
        ..subject = "Password Reset PIN"
        ..text = "Sorry you have forgotten your password.\n"
            "Here is a PIN just for you ${pin.passcode}.\n"
            "Your PIN will expire ${pin.expiration}";

      // TODO: Do something with report
      final report = await send(message, smtpServer);
      _success(pin);
    } on MailerException catch (e) {
      _error(e);
    } catch (e) {
      _error(e);
    }
    // TODO: Remove
    _success(pin);
  }

  void _success(pin) {
    MyToast.toastSuccess(pin.toString());
    // Navigate to the next page
    // Send pin as valid argument
    Navigator.pushReplacementNamed(context, rPIN,
        arguments: {"pin": pin, "username": controller.text});
  }

  void _error(msg) {
    if (kDebugMode) print(msg);
    MyToast.toastError(msg.toString());
  }
}
