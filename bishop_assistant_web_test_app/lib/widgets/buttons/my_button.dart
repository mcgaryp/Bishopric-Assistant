import 'package:bishop_assistant_web_test_app/theme/decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/topography.dart';
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

  const MyButton(
      {required this.label,
      required this.onPressed,
      this.style = MyButtonStyle.primary,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration decor;
    double padding = padding16;
    EdgeInsets topPadding = EdgeInsets.only(top: padding);
    switch (style) {
      case MyButtonStyle.primary:
        decor = floatingLightPrimaryBox;
        padding = padding16;
        break;
      case MyButtonStyle.text:
        decor = invisibleBox;
        padding = padding8;
        break;
      case MyButtonStyle.error:
        decor = floatingErrorRedBox;
        padding = padding8;
        break;
      case MyButtonStyle.standard:
        decor = floatingLightPrimaryBox;
        padding = padding8;
        topPadding = EdgeInsets.only(bottom: padding);
        break;
    }

    return Padding(
      padding: topPadding,
      child: Container(
          constraints: BoxConstraints(minWidth: double.infinity),
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
                  style: bodyLight,
                  textAlign: TextAlign.center,
                )),
          )),
    );
  }
}

enum MyButtonStyle { primary, text, error, standard }
