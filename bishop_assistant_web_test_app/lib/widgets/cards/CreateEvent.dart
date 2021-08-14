import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/FormInputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MyCard.dart';
import 'package:flutter/material.dart';

///
/// CreateEvent.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class CreateEvent extends StatelessWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [
      FormInputField(
        eventName,
        hint: eventNameHint,
      ),
      FormInputField(
        eventName,
        hint: eventNameHint,
      ),
      FormInputField(
        eventName,
        hint: eventNameHint,
      ),
      FormInputField(
        eventName,
        hint: eventNameHint,
      )
    ]);
  }
}
