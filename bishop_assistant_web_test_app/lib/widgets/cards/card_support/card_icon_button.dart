import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// CardIconButton.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class CardIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;

  const CardIconButton(this.icon, {required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed, icon: Icon(icon, color: darkPrimary));
  }
}
