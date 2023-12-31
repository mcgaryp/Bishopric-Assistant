import 'package:the_assistant/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// AutoText.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class AutoText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final bool isExpanded;

  const AutoText(this.data,
      {this.style = bodyDark, this.isExpanded = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          data,
          style: style,
          textAlign: TextAlign.start,
          maxLines: 2,
        ));

    if (isExpanded)
      return Expanded(child: child);
    else
      return child;
  }
}
