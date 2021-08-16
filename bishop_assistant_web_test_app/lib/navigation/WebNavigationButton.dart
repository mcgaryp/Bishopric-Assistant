import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:flutter/material.dart';

///
/// WebNavigationButton.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class WebNavigationButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final String path;
  const WebNavigationButton(
      {this.label, this.icon, required this.path, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? widget;

    if (icon != null)
      widget = IconButton(
        onPressed: () => _navigate(context),
        icon: Icon(icon!, color: white),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        color: Colors.transparent,
        hoverColor: Colors.transparent,
      );

    if (label != null)
      widget = TextButton(
        child: Text(label!, style: buttonStyle),
        onPressed: () => _navigate(context),
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
      );

    if (widget == null) throw ErrorDescription("Label and Icon were both null");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding8),
      child: widget,
    );
  }

  void _navigate(BuildContext context) => Navigator.pushNamed(context, path);
}
