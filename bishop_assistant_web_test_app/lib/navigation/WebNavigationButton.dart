import 'package:bishop_assistant_web_test_app/navigation/NavigationButton.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:flutter/material.dart';

///
/// WebNavigationButton.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class WebNavigationButton extends NavigationButton {
  late final String? label;
  late final IconData? icon;
  late final bool _hasIcon;

  WebNavigationButton.label(this.label, {required String path, Key? key})
      : super(path, key: key) {
    _hasIcon = false;
  }

  WebNavigationButton.icon(this.icon, {required String path, Key? key})
      : super(path, key: key) {
    _hasIcon = true;
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = _hasIcon ? _icon(context) : _text(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding8),
      child: widget,
    );
  }

  Widget _icon(BuildContext context) {
    return IconButton(
      onPressed: () => navigate(context),
      icon: Icon(icon!, color: light),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      color: Colors.transparent,
      hoverColor: Colors.transparent,
    );
  }

  Widget _text(BuildContext context) {
    return TextButton(
      child: Text(label!, style: bodyLight),
      onPressed: () => navigate(context),
      style: textButtonStyle,
    );
  }
}
