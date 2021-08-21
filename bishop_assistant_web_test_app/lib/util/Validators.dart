///
/// Validators.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/21/21
/// Copyright 2021 Po. All rights reserved.
///

class Validators {
  static String? validateDropDown(dynamic item) {
    if (item == null) return "Must select one";

    return null;
  }

  // Validation should always contain
  // - A field cannot be empty
  // - A field cannot have whitespace
  static String? standard(String? text) {
    if (text == null || text.isEmpty) return "Field cannot be empty";

    if (text.startsWith(" ") || text.endsWith(" "))
      return "Field cannot start or end with WhiteSpace";

    return null;
  }
}
