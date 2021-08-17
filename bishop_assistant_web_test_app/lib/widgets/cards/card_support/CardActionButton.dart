import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:flutter/material.dart';

///
/// CardActionButton.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class CardActionButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final MyButtonStyle style;

  const CardActionButton(this.label,
      {required this.onPressed, this.style = MyButtonStyle.primary, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration decor;

    switch (style) {
      case MyButtonStyle.primary:
        decor = primaryButtonDecoration;
        break;
      case MyButtonStyle.text:
        decor = textButtonDecoration;
        break;
      case MyButtonStyle.error:
        decor = errorDecoration;
        break;
    }

    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(padding8),
      child: Container(
          decoration: decor,
          child: Padding(
            padding: const EdgeInsets.all(padding8),
            child: TextButton(
              style: textButtonStyle,
                onPressed: onPressed,
                child: Text(label,
                    style: buttonStyle, textAlign: TextAlign.center)),
          )),
    ));
  }
}
