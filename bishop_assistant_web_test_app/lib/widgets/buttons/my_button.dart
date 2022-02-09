import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';

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
  final Icon? icon;

  const MyButton(
      {required this.label,
      required this.onPressed,
      this.style = MyButtonStyle.floating,
      this.isExpanded = true,
      Key? key})
      : icon = null,
        super(key: key);

  const MyButton.icon({required this.icon, required this.onPressed, Key? key})
      : label = "",
        style = MyButtonStyle.text,
        isExpanded = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration decor;
    EdgeInsets padding = EdgeInsets.all(padding8);
    EdgeInsets insidePadding =
        EdgeInsets.symmetric(horizontal: padding8, vertical: padding4);
    TextStyle textStyle = bodyLight;
    switch (style) {
      case MyButtonStyle.text:
        decor = invisibleBox;
        textStyle = body;
        padding = EdgeInsets.zero;
        break;
      case MyButtonStyle.lightText:
        decor = invisibleBox;
        padding = EdgeInsets.zero;
        textStyle = bodyLight;
        break;
      case MyButtonStyle.darkText:
        textStyle = bodyDark;
        padding = EdgeInsets.zero;
        decor = invisibleBox;
        break;
      case MyButtonStyle.errorText:
        textStyle = bodyRed;
        padding = EdgeInsets.zero;
        decor = invisibleBox;
        break;
      case MyButtonStyle.smallText:
        decor = invisibleBox;
        textStyle = captionDark;
        padding = EdgeInsets.zero;
        break;
      case MyButtonStyle.floating:
        decor = floatingLightPrimaryBox;
        if (kIsWeb)
          insidePadding =
              EdgeInsets.symmetric(horizontal: padding16, vertical: padding16);
        else
          insidePadding =
              EdgeInsets.symmetric(horizontal: padding16, vertical: padding8);
        break;
      case MyButtonStyle.floatingError:
        decor = floatingErrorRedBox;
        if (kIsWeb)
          insidePadding =
              EdgeInsets.symmetric(horizontal: padding16, vertical: padding16);
        else
          insidePadding =
              EdgeInsets.symmetric(horizontal: padding16, vertical: padding8);
        break;
    }

    return Padding(
      padding: padding,
      child: Container(
          decoration: decor,
          constraints:
              isExpanded ? BoxConstraints(minWidth: double.infinity) : null,
          child: TextButton(
              onPressed: onPressed,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(insidePadding),
                shape: MaterialStateProperty.all(roundedBorder),
                minimumSize: MaterialStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: icon ??
                  Text(
                    label,
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ))),
    );
  }
}

enum MyButtonStyle {
  errorText,
  floatingError,
  floating,
  darkText,
  lightText,
  text,
  smallText,
}
