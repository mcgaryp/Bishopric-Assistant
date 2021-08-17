import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/FormInputField.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// CardDateTimeRow.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class CardDateTimeRow extends StatelessWidget {
  const CardDateTimeRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Expanded(child: TextField())
        Flexible(
          flex: 2,
          child: FormInputField(
            date,
            hint: DateFormat.MMMMEEEEd().format(DateTime.now()),
          ),
        ),
        Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: padding16),
              child: FormInputField(time, hint: DateFormat.jm().format(DateTime.now())),
            ))
      ],
    );
  }
}
