import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final MyButtonStyle style;
  const MyButton(
      {required this.label,
      required this.onPressed,
      this.style = MyButtonStyle.primary,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration decor;
    double padding;
    switch (style) {
      case MyButtonStyle.primary:
        decor = primaryButtonDecoration;
        padding = padding16;
        break;
      case MyButtonStyle.text:
        decor = textButtonDecoration;
        padding = padding8;
        break;
    }

    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: Container(
          constraints: BoxConstraints(minWidth: double.infinity),
          decoration: decor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: padding8),
            child: TextButton(
                onPressed: onPressed,
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                child: Text(
                  label,
                  style: buttonStyle,
                )),
          )),
    );
  }
}

enum MyButtonStyle { primary, text }
