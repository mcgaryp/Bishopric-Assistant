import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// CardButton.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class CardButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const CardButton({required this.label, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(label, style: bodyDark),
        style: textButtonStyle);
  }
}
