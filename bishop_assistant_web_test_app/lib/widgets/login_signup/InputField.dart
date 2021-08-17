import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:flutter/material.dart';

///
/// InputField.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class InputField extends StatefulWidget {
  final String hint;
  final bool isPassword;

  const InputField(this.hint, {this.isPassword = false, Key? key})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: padding16),
      child: Container(
        decoration: floatingLightBox,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding16),
          child: TextField(
            obscureText: widget.isPassword,
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: widget.hint,
              hintStyle: captionLight,
              labelStyle: bodyDark,
            ),
          ),
        ),
      ),
    );
  }
}
