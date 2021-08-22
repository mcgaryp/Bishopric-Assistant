import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/database/models/Organization.dart';
import 'package:bishop_assistant_web_test_app/database/models/OrganizationMembers.dart';
import 'package:bishop_assistant_web_test_app/database/models/Role.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/util/Validators.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseDropDown.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/DarkPage.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

///
/// Signup.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // Key used to
  final _formKey = GlobalKey<FormState>();

  // TextEditingControllers
  TextEditingController fNameControl = TextEditingController();
  TextEditingController lNameControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmControl = TextEditingController();
  TextEditingController organizationControl = TextEditingController();

  // Format the number
  MaskTextInputFormatter filter = MaskTextInputFormatter(
      mask: "(###) ###-####", filter: {"#": RegExp(r'\d')});

  // Selected user role
  Role? _selectedRole;

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
  }

  @override
  Widget build(BuildContext context) {
    return DarkPage(showSpinner: _isWaiting, inputs: [
      Form(
        key: _formKey,
        child: Column(
          children: [
            InputField.floating(firstname,
                controller: fNameControl, validator: _verifyName),
            InputField.floating(lastname,
                controller: lNameControl, validator: _verifyName),
            InputField.floating(email,
                controller: emailControl, validator: _verifyEmail),
            InputField.floating(phone,
                controller: phoneControl,
                formattingList: [filter],
                validator: Validators.standard),
            InputField.floating(password,
                isPassword: true,
                controller: passwordControl,
                validator: _password),
            InputField.floating(confirmPassword,
                isPassword: true,
                controller: confirmControl,
                validator: _confirmPassword),
            FirebaseDropDown(
                collectionPath: Collections.roles,
                hint: role,
                onchange: _roleChange,
                validator: _validateRole),
            if (_selectedRole != null)
              if (_selectedRole == Role.bishop)
                InputField.floating(nameOfOrganization,
                    validator: Validators.standard,
                    controller: organizationControl),
          ],
        ),
      ),
    ], buttons: [
      AbsorbPointer(
        absorbing: _isWaiting,
        child: MyButton(
            label: signup,
            onPressed: () async {
              /// prevent the user from pressing the button more than once while backend thinks
              _setIsWaiting(true);

              /// Verify information in form
              if (_formKey.currentState!.validate()) {
                /// Password encryption
                String hashPassword =
                    Crypt.sha256(passwordControl.text, salt: "bishopric")
                        .toString();

                /// Create member model
                Member member = Member.create(
                  firstName: fNameControl.text,
                  lastName: lNameControl.text,
                  phone: phoneControl.text,
                  email: emailControl.text,
                  password: hashPassword,
                  role: _selectedRole!,
                );

                /// Create the member in database
                FirestoreHelper.addDocument(Collections.members,
                    doc: member,
                    error: (error) => _setIsWaiting(false),
                    success: (memberID) {
                      /// Create organization
                      if (organizationControl.text.isNotEmpty) {
                        /// Add organization to the database
                        FirestoreHelper.addDocument(Collections.organizations,
                            doc: Organization(-1, organizationControl.text),
                            error: (error) => _setIsWaiting(false),
                            success: (organizationID) {
                              /// Tie organization and member together
                              FirestoreHelper.addDocument(
                                  Collections.organization_members,
                                  doc: OrganizationMembers(
                                      memberID, organizationID),
                                  error: (error) => _setIsWaiting(false),
                                  success: (organizationMemberID) {
                                    _setIsWaiting(false);
                                    Navigator.pop(context);
                                  });
                            });
                      } else {
                        _setIsWaiting(false);
                        Navigator.pop(context);
                      }
                    });
              } else
                _setIsWaiting(false);
            }),
      )
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

  /// Validate Role
  /// - Role may not be empty
  String? _validateRole(role) {
    if (role == null) return "Select a role";
  }

  /// Update the role to what ever has been selected
  void _roleChange(selectedRole) {
    setState(() {
      _selectedRole = ParseRolesToString.roleFromString(selectedRole);
    });
  }
}
