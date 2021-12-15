import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/widgets/buttons/navigation_button.dart';
import 'package:flutter/material.dart';

///
/// CardNavigationButton.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/18/21
/// Copyright 2021 Po. All rights reserved.
///

class CardNavigationButton extends NavigationButton {
  final String label;

  const CardNavigationButton(this.label, {required String path, Key? key})
      : super(path, key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Padding(
          padding: const EdgeInsets.all(padding8),
          child: Text(label, style: bodyDark)),
      onPressed: () => navigate(context),
      style: textButtonStyle,
    );
  }
}
