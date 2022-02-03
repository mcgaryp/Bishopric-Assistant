import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';

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
    EdgeInsets? padding = EdgeInsets.all(padding8);
    TextStyle textStyle = bodyLight;
    switch (style) {
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
        break;
      case MyButtonStyle.lightText:
        decor = invisibleBox;
        padding = EdgeInsets.zero;
        textStyle = bodyLight;
        break;
      case MyButtonStyle.errorText:
        textStyle = bodyRed;
        padding = EdgeInsets.zero;
        decor = invisibleBox;
        break;
      case MyButtonStyle.darkText:
        textStyle = captionDark;
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
            padding:
                EdgeInsets.symmetric(vertical: icon == null ? padding8 : 0),
            child: TextButton(
                onPressed: onPressed,
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                child: icon ??
                    Text(
                      label,
                      style: textStyle,
                      textAlign: TextAlign.center,
                    )),
          )),
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
}
