import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// my_button.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class MyButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final MyButtonStyle style;
  final bool isExpanded;

  const MyButton(
      {required this.label,
      required this.onPressed,
      this.style = MyButtonStyle.primary,
      this.isExpanded = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration decor;
    EdgeInsets? padding = EdgeInsets.only(top: padding16);
    TextStyle textStyle = bodyLight;
    switch (style) {
      case MyButtonStyle.primary:
        decor = floatingLightPrimaryBox;
        break;
      case MyButtonStyle.text:
        decor = invisibleBox;
        textStyle = bodyDark;
        padding = EdgeInsets.zero;
        break;
      case MyButtonStyle.floatingError:
        decor = floatingErrorRedBox;
        break;
      case MyButtonStyle.floating:
        decor = floatingLightPrimaryBox;
        padding = EdgeInsets.only(bottom: padding8);
        break;
      case MyButtonStyle.lightText:
        decor = invisibleBox;
        padding = EdgeInsets.zero;
        textStyle = captionLight;
        break;
      case MyButtonStyle.errorText:
        textStyle = bodyRed;
        padding = EdgeInsets.zero;
        decor = invisibleBox;
        break;
    }

    return Padding(
      padding: padding,
      child: Container(
          constraints:
              isExpanded ? BoxConstraints(minWidth: double.infinity) : null,
          decoration: decor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: padding8),
            child: TextButton(
                onPressed: onPressed,
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                child: Text(
                  label,
                  style: textStyle,
                  textAlign: TextAlign.center,
                )),
          )),
    );
  }
}

enum MyButtonStyle {
  primary,
  text,
  floatingError,
  floating,
  lightText,
  errorText
}
