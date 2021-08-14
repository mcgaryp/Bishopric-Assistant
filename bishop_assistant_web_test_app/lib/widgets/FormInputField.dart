import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:flutter/material.dart';

///
/// FormInputField.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class FormInputField extends StatelessWidget {
  final String label;
  final String hint;
  const FormInputField(this.label, {this.hint = "", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          // TODO: Border
          hintText: hint,
          hintStyle: hintStyle,
          labelText: label,
          labelStyle: bodyStyle),
      onSaved: (String? value) {
        print('Value saved as "$value"');
      },
    );
  }
}
