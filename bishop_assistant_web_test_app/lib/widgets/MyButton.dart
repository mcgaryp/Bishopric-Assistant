import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  const MyButton({required this.label, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: padding16),
      child: Container(
          constraints: BoxConstraints(minWidth: double.infinity),
          decoration: buttonDecoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: padding8),
            child: TextButton(
                onPressed: onPressed,
                child: Text(
                  label,
                  style: buttonStyle,
                )),
          )),
    );
  }
}
