import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:flutter/material.dart';

///
/// CardNavigationButton.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/18/21
/// Copyright 2021 Po. All rights reserved.
///

class CardNavigationButton extends StatelessWidget {
  final String label;
  final String path;
  const CardNavigationButton(this.label, {required this.path, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.all(padding8),
        child: Text(label, style: bodyDark)
      ),
      onPressed: () => _navigate(context),
      style: textButtonStyle,
    );
  }

  void _navigate(BuildContext context) => Navigator.pushNamed(context, path);
}