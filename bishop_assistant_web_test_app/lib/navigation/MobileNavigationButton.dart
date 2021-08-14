import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:flutter/material.dart';

///
/// MobileNavigationButton.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class MobileNavigationButton extends StatelessWidget {
  final String label;
  final String path;
  const MobileNavigationButton(this.label, this.path, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.all(padding8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: darkButtonStyle),
            Icon(Icons.arrow_forward_rounded, color: blackText)
          ],
        ),
      ),
      onPressed: () => _navigate(context),
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
    );
  }

  void _navigate(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, path);
  }
}
