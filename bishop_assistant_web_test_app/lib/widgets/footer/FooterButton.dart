import 'package:bishop_assistant_web_test_app/theme/topography.dart';
import 'package:flutter/material.dart';

///
/// FooterButton.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class FooterButton extends StatelessWidget {
  final String label;
  final String path;

  const FooterButton({required this.label, required this.path, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _navigate(context),
      child: Text(label, style: bodyDark),
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
    );
  }

  void _navigate(BuildContext context) => Navigator.pushNamed(context, path);
}
