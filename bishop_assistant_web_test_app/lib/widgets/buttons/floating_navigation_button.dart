import 'package:the_assistant/theme/theme.dart';
import 'package:the_assistant/widgets/buttons/navigation_button.dart';
import 'package:flutter/material.dart';

///
/// FloatingNavigationButton.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class FloatingNavigationButton extends NavigationButton {
  const FloatingNavigationButton(String path, {Key? key})
      : super(path, key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: padding8),
        child: FloatingActionButton(
            backgroundColor: lightPrimary,
            splashColor: Colors.transparent,
            onPressed: () => navigate(context),
            child: Icon(Icons.add, color: light, size: 55)),
      ),
    );
  }
}
