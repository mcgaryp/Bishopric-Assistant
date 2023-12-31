import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

///
/// Validators.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/21/21
/// Copyright 2021 Po. All rights reserved.
///

class Validators {
  // Format the number
  static MaskTextInputFormatter phoneFilter = MaskTextInputFormatter(
      mask: "(###) ###-####", filter: {"#": RegExp(r'\d')});

  // Validate DropDown Menu
  // - Cannot be empty
  static String? validateDropDown(dynamic item) {
    if (item == null) return "Must select one";
    return null;
  }

  // Validation should always contain
  // - A field cannot be empty
  // - A field cannot have whitespace
  static String? standard(String? text, {bool isUpdating = false}) {
    if (text == null) return "Field is null";
    if (text.isEmpty && !isUpdating) return "Field cannot be empty";

    if (text.startsWith(" ") || text.endsWith(" "))
      return "Field cannot start or end with WhiteSpace";

    return null;
  }

  // Validate a MultiSelect Field
  // - Cannot be empty
  static String? validateMultiSelect(List<Object?>? list) {
    if (list == null || list.isEmpty) return "Must select at least 1";
    return null;
  }

  // Password Validation
  // - Must be at least 8 characters
  // - Must have at least one number
  // - Must have at least one symbol
  static String? validatePassword(String? text, {bool isUpdating = false}) {
    String? returnValue = Validators.standard(text);

    if (text != null) {
      if (text.isEmpty && isUpdating) return null;
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

  // Verify Confirming Password
  // - Standard
  // - Must match password text
  static String? validateConfirmPassword(String? text, String? password,
      {bool isUpdating = false}) {
    String? returnValue = Validators.standard(text);

    if (text != null && password != null) {
      if (text.isEmpty && password.isEmpty && isUpdating) return null;
      if (text != password) return "Passwords do not match";

      return returnValue;
    }
    return null;
  }

  // Verify email
  // - Emails must have an @
  // - Emails must have something before the @
  // - Emails must have something after the @ along with a . following that
  // - Emails must have something after the .
  // Send a verification email on create
  static String? validateEmail(String? text, {bool isUpdating = false}) {
    String? returnValue = Validators.standard(text);

    if (text != null) {
      if (text.isEmpty && isUpdating) return null;
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

  // Verify Names
  // - Names do not have a limit to how many letters are in them
  // - Names do not have whitespace at the end or start of them
  // - Name should start with a capital letter
  static String? validateName(String? text, {bool isUpdating = false}) {
    String? returnValue = Validators.standard(text);

    if (text != null) {
      if (text.isEmpty && isUpdating) return null;
      RegExp regExp = RegExp(
        r"\d",
        caseSensitive: false,
        multiLine: false,
      );

      if (regExp.hasMatch(text)) returnValue = "Names cannot contain numbers";
    }

    return returnValue;
  }
}
