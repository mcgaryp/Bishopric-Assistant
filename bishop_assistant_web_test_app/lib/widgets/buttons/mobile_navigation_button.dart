import 'package:the_assistant/theme/theme.dart';
import 'package:the_assistant/widgets/buttons/navigation_button.dart';
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
  final int? notifications;

  const MobileNavigationButton(this.label,
      {required String path, this.notifications, Key? key})
      : super(path, key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.all(padding8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: body),
            Icon(Icons.arrow_forward_rounded, color: dark)
          ],
        ),
      ),
      onPressed: () => navigate(context),
      style: textButtonStyle,
    );
  }
}
