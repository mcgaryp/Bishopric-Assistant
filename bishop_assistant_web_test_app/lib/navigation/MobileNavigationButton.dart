import 'package:bishop_assistant_web_test_app/navigation/NavigationButton.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:flutter/material.dart';

///
/// MobileNavigationButton.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class MobileNavigationButton extends NavigationButton {
  final String label;

  const MobileNavigationButton(this.label, String path, {Key? key})
      : super(path, key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.all(padding8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: bodyDark),
            Icon(Icons.arrow_forward_rounded, color: dark)
          ],
        ),
      ),
      onPressed: () => navigate(context),
      style: textButtonStyle,
    );
  }
}
