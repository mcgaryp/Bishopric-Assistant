import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/services.dart';

///
/// CardTextFieldRow.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/17/21
/// Copyright 2021 Po. All rights reserved.
///

class CardTextFieldRow extends StatelessWidget {
  final String label;
  final String secondLabel;
  final String hint;

  const CardTextFieldRow(this.label,
      {this.secondLabel = "", this.hint = "", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        AutoText(
          label,
          style: body,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: padding8),
            child: InputField.border(
              secondLabel,
              hint: hint,
              formattingList: [FilteringTextInputFormatter.digitsOnly],
              inputType: TextInputType.number,
            ),
          ),
        ),
      ],
    );
  }
}
