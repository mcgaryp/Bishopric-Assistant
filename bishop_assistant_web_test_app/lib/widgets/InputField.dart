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

class InputField extends StatefulWidget {
  final String label;
  final String hint;
  final bool maxLines;
  final List<TextInputFormatter> formattingList;
  final TextInputType? inputType;
  final bool isPassword;
  late final bool _isFloating;

  InputField.border(this.label,
      {this.hint = "",
      this.maxLines = false,
      this.formattingList = const [],
      this.inputType,
      this.isPassword = false,
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
      Key? key})
      : super(key: key) {
    this._isFloating = true;
  }

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget._isFloating ? padding16 : padding8),
      child: Container(
        decoration: widget._isFloating ? floatingLightBox : null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: widget._isFloating ? padding8 : 0),
          child: TextField(
            obscureText: widget.isPassword,
            controller: _controller,
            maxLines: widget.maxLines ? null : 1,
            inputFormatters: widget.formattingList,
            keyboardType: widget.inputType,
            decoration: widget._isFloating ? _floating() : _border(),
            onChanged: (String? value) {
              print('Value saved as "$value"');
            },
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
      hintText: widget.hint,
      hintStyle: captionLight,
      labelStyle: bodyDark,
    );
  }

  InputDecoration _border() {
    return InputDecoration(
        focusedBorder: lightPrimaryInputBorder,
        enabledBorder: darkPrimaryInputBorder,
        errorBorder: errorRedInputBorder,
        hintText: widget.hint,
        hintStyle: captionLight,
        labelText: widget.label,
        labelStyle: bodyDark);
  }
}
