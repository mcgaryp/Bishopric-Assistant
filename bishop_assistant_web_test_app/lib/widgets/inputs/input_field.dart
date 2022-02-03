import 'package:bishop_assistant_web_test_app/theme/theme.dart';
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
  final String? errorMsg;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;
  final void Function(String?)? onSubmit;
  final List<TextInputFormatter> formattingList;
  final TextEditingController? controller;
  final bool maxLines;
  final bool isPassword;
  final bool errorColorIsDark;
  final double padding;
  late final bool? _isFloating;
  final FocusNode? focus;

  InputField.border(this.label,
      {this.hint = "",
      this.maxLines = false,
      this.formattingList = const [],
      this.inputType,
      this.isPassword = false,
      this.controller,
      this.validator,
      this.errorMsg,
      this.onSubmit,
      this.errorColorIsDark = true,
      this.padding = padding8,
      this.focus,
      this.onChange,
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
      this.validator,
      this.errorMsg,
      this.onSubmit,
      this.errorColorIsDark = false,
      this.padding = padding16,
      this.focus,
      this.onChange,
      Key? key})
      : super(key: key) {
    this._isFloating = true;
  }

  InputField.plain(this.hint,
      {this.label = "",
      this.maxLines = false,
      this.formattingList = const [],
      this.inputType,
      this.isPassword = false,
      this.controller,
      this.validator,
      this.errorMsg,
      this.onSubmit,
      this.errorColorIsDark = true,
      this.padding = 0.0,
      this.focus,
      this.onChange,
      Key? key})
      : super(key: key) {
    _isFloating = null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: Stack(
        children: [
          Container(
              height: 48,
              decoration: _isFloating == null
                  ? null
                  : _isFloating!
                      ? floatingLightBox
                      : null),
          TextFormField(
            focusNode: focus,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            obscureText: isPassword,
            maxLines: maxLines ? null : 1,
            inputFormatters: formattingList,
            keyboardType: inputType,
            decoration: _isFloating == null
                ? _plain()
                : _isFloating!
                    ? _floating()
                    : _border(),
            validator: validator,
            onFieldSubmitted: onSubmit,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }

  InputDecoration _floating() {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: padding16),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: errorRedInputBorder,
      disabledBorder: InputBorder.none,
      errorStyle: errorColorIsDark ? calloutDark : calloutLight,
      hintText: hint,
      hintStyle: captionDark,
      labelStyle: bodyDark,
      errorText: errorMsg,
    );
  }

  InputDecoration _border() {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: padding16),
      focusedBorder: lightPrimaryInputBorder,
      enabledBorder: darkPrimaryInputBorder,
      errorBorder: errorRedInputBorder,
      errorStyle: errorColorIsDark ? calloutDark : calloutLight,
      hintText: hint,
      hintStyle: captionLight,
      labelText: label,
      labelStyle: bodyDark,
    );
  }

  InputDecoration _plain() {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: padding16),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: errorRedInputBorder,
      disabledBorder: InputBorder.none,
      errorStyle: errorColorIsDark ? calloutDark : calloutLight,
      hintText: hint,
      hintStyle: captionDark,
      labelStyle: bodyDark,
      errorText: errorMsg,
    );
  }
}
