import 'package:the_assistant/theme/theme.dart';
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
  final String? label;
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
  final double padding;
  final bool? _isFloating;
  final FocusNode? focus;
  final TextStyle errorStyle;

  InputField.border(this.hint,
      {this.label,
      this.maxLines = false,
      this.formattingList = const [],
      this.inputType,
      this.isPassword = false,
      this.controller,
      this.validator,
      this.errorMsg,
      this.onSubmit,
      this.padding = padding8,
      this.focus,
      this.onChange,
      this.errorStyle = captionRed,
      Key? key})
      : this._isFloating = false,
        super(key: key);

  InputField.floating(this.hint,
      {this.label,
      this.maxLines = false,
      this.formattingList = const [],
      this.inputType,
      this.isPassword = false,
      this.controller,
      this.validator,
      this.errorMsg,
      this.onSubmit,
      this.padding = padding16,
      this.errorStyle = captionLight,
      this.focus,
      this.onChange,
      Key? key})
      : this._isFloating = true,
        super(key: key);

  InputField.plain(this.hint,
      {this.label,
      this.maxLines = false,
      this.formattingList = const [],
      this.inputType,
      this.isPassword = false,
      this.controller,
      this.validator,
      this.errorMsg,
      this.onSubmit,
      this.padding = 0.0,
      this.errorStyle = captionRed,
      this.focus,
      this.onChange,
      Key? key})
      : _isFloating = null,
        super(key: key);

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
      errorStyle: errorStyle,
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
      errorStyle: errorStyle,
      hintText: hint,
      hintStyle: captionLight,
      labelText: label ?? hint,
      labelStyle: bodyDark,
    );
  }

  InputDecoration _plain() {
    return InputDecoration(
      labelText: label ?? hint,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: errorRedInputBorder,
      disabledBorder: InputBorder.none,
      errorStyle: errorStyle,
      labelStyle: subhead,
      errorText: errorMsg,
    );
  }
}
