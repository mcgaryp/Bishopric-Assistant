import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:flutter/material.dart';

///
/// FloatingNavigationButton.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class FloatingNavigationButton extends StatelessWidget {
  final String path;
  const FloatingNavigationButton(this.path, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: padding8),
        child: FloatingActionButton(
            backgroundColor: lightAccent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            onPressed: () => _navigate(context),
            child: Icon(Icons.add, color: white, size: 55)),
      ),
    );
  }

  void _navigate(BuildContext context) => Navigator.pushNamed(context, path);
}
