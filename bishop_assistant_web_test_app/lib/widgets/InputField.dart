import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// InputField.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType? inputType;
  final List<TextInputFormatter> formattingList;
  final TextEditingController? controller;
  final bool maxLines;
  final bool isPassword;
  late final bool _isFloating;

  InputField.border(this.label,
      {this.hint = "",
      this.maxLines = false,
      this.formattingList = const [],
      this.inputType,
      this.isPassword = false,
      this.controller,
      Key? key})
      : super(key: key) {
    this._isFloating = false;
  }

  InputField.floating(this.hint,
      {this.label = "",
      this.maxLines = false,
      this.formattingList = const [],
      this.inputType,
      this.isPassword = false,
      this.controller,
      Key? key})
      : super(key: key) {
    this._isFloating = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: _isFloating ? padding16 : padding8),
      child: Container(
        decoration: _isFloating ? floatingLightBox : null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _isFloating ? padding8 : 0),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            maxLines: maxLines ? null : 1,
            inputFormatters: formattingList,
            keyboardType: inputType,
            decoration: _isFloating ? _floating() : _border(),
            // onChanged: onChange,
          ),
        ),
      ),
    );
  }

  InputDecoration _floating() {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintText: hint,
      hintStyle: captionLight,
      labelStyle: bodyDark,
    );
  }

  InputDecoration _border() {
    return InputDecoration(
        focusedBorder: lightPrimaryInputBorder,
        enabledBorder: darkPrimaryInputBorder,
        errorBorder: errorRedInputBorder,
        hintText: hint,
        hintStyle: captionLight,
        labelText: label,
        labelStyle: bodyDark);
  }
}
