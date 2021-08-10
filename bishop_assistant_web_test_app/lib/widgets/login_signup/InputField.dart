import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String hint;

  const InputField({required this.hint, Key? key}) : super(key: key);

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
        decoration: boxDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding16),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: widget.hint,
              hintStyle: hintStyle,
              labelStyle: labelStyle,
            ),
          ),
        ),
      ),
    );
  }
}
