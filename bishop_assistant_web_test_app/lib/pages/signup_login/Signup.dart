import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/DarkPage.dart';
import 'package:flutter/material.dart';

///
/// Signup.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

// TODO: Add Firebase Input Possible
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController fNameControl = TextEditingController();
  TextEditingController lNameControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmControl = TextEditingController();

  bool isWaiting = false;

  @override
  void initState() {
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
  }

  @override
  Widget build(BuildContext context) {
    return DarkPage(inputs: [
      // TODO: Add verification to each input field
      InputField.floating(firstname, controller: fNameControl),
      InputField.floating(lastname, controller: lNameControl),
      InputField.floating(email, controller: emailControl),
      InputField.floating(phone, controller: phoneControl),
      InputField.floating(password,
          isPassword: true, controller: passwordControl),
      InputField.floating(confirmPassword,
          isPassword: true, controller: confirmControl),
      // TODO: Setup dropdown to give me something back when it changes
      // FirebaseDropDown(
      //     collectionPath: Collections.roles, document: RolesDoc(), hint: role),
      // TODO: Only show line 64 if the user role is bishop
      // InputField.floating(nameOfOrganization),
    ], buttons: [
      AbsorbPointer(
        absorbing: isWaiting,
        child: MyButton(
            label: signup,
            onPressed: () async {
              // prevent the user from pressing the button more than once while backend thinks
              // TODO: Add spinner to indicate that the app is thinking
              _setIsWaiting(true);

              // TODO: Verification of information
              // TODO: Password encryption
              // TODO: Save password
              Member member = Member.create(
                  firstName: fNameControl.text,
                  lastName: lNameControl.text,
                  phone: phoneControl.text,
                  email: emailControl.text);

              // create the member
              FirestoreHelper.createMember(member,
                  onError: (error) => _setIsWaiting(false),
                  onSuccess: () {
                    _setIsWaiting(false);
                    Navigator.pop(context);
                  });
            }),
      ) //Navigator.pop(context))
    ]);
  }

  _setIsWaiting(bool val) {
    setState(() {
      isWaiting = val;
    });
  }
}
