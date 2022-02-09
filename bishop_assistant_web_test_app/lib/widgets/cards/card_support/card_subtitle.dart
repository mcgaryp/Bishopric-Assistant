import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// CardSubtitle.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class CardSubtitle extends StatelessWidget {
  final DateTime dateTime;
  final String? location;
  final TextStyle _style;

  const CardSubtitle(this.dateTime, {this.location, Key? key})
      : this._style = caption,
        super(key: key);

  const CardSubtitle.light(this.dateTime, {this.location, Key? key})
      : this._style = captionLight,
        super(key: key);

  const CardSubtitle.dark(this.dateTime, {this.location, Key? key})
      : this._style = calloutDark,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.MMMMEEEEd().format(dateTime);
    String time = DateFormat.jm().format(dateTime);

    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(date, style: _style),
            Text(time, style: _style),
          ]),
          if (location != null)
            Text(
              location!,
              style: _style,
            )
        ],
      ),
    );
  }
}
