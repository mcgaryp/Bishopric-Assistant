import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:flutter/material.dart';

///
/// FormInputField.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class FormInputField extends StatefulWidget {
  final String label;
  final String hint;
  final bool maxLines;

  const FormInputField(this.label,
      {this.hint = "", this.maxLines = false, Key? key})
      : super(key: key);

  @override
  _FormInputFieldState createState() => _FormInputFieldState();
}

class _FormInputFieldState extends State<FormInputField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: TextField(
        controller: _controller,
        maxLines: widget.maxLines ? null : 1,
        decoration: InputDecoration(
            focusedBorder: lightPrimaryInputBorder,
            enabledBorder: darkPrimaryInputBorder,
            errorBorder: errorRedInputBorder,
            hintText: widget.hint,
            hintStyle: captionLight,
            labelText: widget.label,
            labelStyle: captionLight),
        onChanged: (String? value) {
          print('Value saved as "$value"');
        },
      ),
    );
  }
}
