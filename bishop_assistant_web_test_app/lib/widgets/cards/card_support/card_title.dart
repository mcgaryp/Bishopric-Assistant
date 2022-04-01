import 'package:the_assistant/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// CardTitle.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class CardTitle extends StatelessWidget {
  final String title;
  final TextStyle _style;

  const CardTitle(this.title, {Key? key})
      : this._style = headline,
        super(key: key);

  const CardTitle.light(this.title, {Key? key})
      : this._style = headlineLight,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: padding4),
      child: Text(title, style: _style, maxLines: null),
    );
  }
}
