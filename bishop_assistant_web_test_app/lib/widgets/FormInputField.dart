import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: TextField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightAccent),
                borderRadius: borderRadius20),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: darkAccent),
                borderRadius: borderRadius20),
            hintText: hint,
            hintStyle: hintStyle,
            labelText: label,
            labelStyle: bodyStyle),
        onChanged: (String? value) {
          print('Value saved as "$value"');
        },
      ),
    );
  }
}
