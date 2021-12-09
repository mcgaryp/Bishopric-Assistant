import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/widgets/buttons/navigation_button.dart';
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
  final int? notifications;

  WebNavigationButton.label(this.label,
      {required String path, this.notifications, Key? key})
      : super(path, key: key) {
    _hasIcon = false;
  }

  WebNavigationButton.icon(this.icon,
      {required String path, this.notifications, Key? key})
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
      child: Row(
        children: [
          Text(label!, style: bodyLight),
          if (notifications != null) _notificationWidget,
        ],
      ),
      onPressed: () => navigate(context),
      style: textButtonStyle,
    );
  }

  Widget get _notificationWidget {
    return Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(child: Text("$notifications", style: bodyLight)),
            )));
  }
}
