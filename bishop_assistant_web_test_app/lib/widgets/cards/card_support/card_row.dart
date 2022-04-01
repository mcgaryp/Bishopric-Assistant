import 'package:the_assistant/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///
/// CardRow.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class CardRow extends StatelessWidget {
  final String label;
  final String content;
  final TextStyle _labelStyle;
  final TextStyle _contentStyle;

  const CardRow(this.label, {required this.content, Key? key})
      : this._labelStyle = subhead,
        this._contentStyle = body,
        super(key: key);

  const CardRow.light(this.label, {required this.content, Key? key})
      : this._labelStyle = subheadLight,
        this._contentStyle = bodyLight,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: _labelStyle),
          SizedBox(width: 15),
          Flexible(
              child: Text(
            content,
            style: _contentStyle,
            overflow: TextOverflow.fade,
            maxLines: null,
            textAlign: TextAlign.right,
          ))
        ],
      ),
    );
  }
}
