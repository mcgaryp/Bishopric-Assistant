import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
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
  const CardSubtitle(this.dateTime, {this.location, Key? key})
      : super(key: key);

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
            Text(date, style: captionStyle),
            Text(time, style: captionStyle),
          ]),
          if (location != null)
            Text(
              location!,
              style: captionStyle,
            )
        ],
      ),
    );
  }
}
