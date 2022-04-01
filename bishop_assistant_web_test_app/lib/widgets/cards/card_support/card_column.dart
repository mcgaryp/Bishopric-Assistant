import 'package:the_assistant/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// CardColumn.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/17/21
/// Copyright 2021 Po. All rights reserved.
///

class CardColumn extends StatelessWidget {
  final String label;
  final String content;
  final TextStyle _labelStyle;
  final TextStyle _contentStyle;

  const CardColumn(this.label, {required this.content, Key? key})
      : this._labelStyle = subhead,
        this._contentStyle = body,
        super(key: key);

  const CardColumn.light(this.label, {required this.content, Key? key})
      : this._labelStyle = subheadLight,
        this._contentStyle = bodyLight,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: _labelStyle),
          Text(content, style: _contentStyle),
        ],
      ),
    );
  }
}
