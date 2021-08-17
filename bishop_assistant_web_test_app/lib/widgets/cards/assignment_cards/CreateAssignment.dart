import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseDropDown.dart';
import 'package:bishop_assistant_web_test_app/widgets/FormInputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardDateTimeRow.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:flutter/material.dart';

///
/// CreateAssignment.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/15/21
/// Copyright 2021 Po. All rights reserved.
///

class CreateAssignment extends StatelessWidget {
  const CreateAssignment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [
      FormInputField(assignmentName, hint: assignmentNameHint),
      CardDateTimeRow(),
      FirebaseDropDown(
          collectionPath: Collections.members, document: MembersDoc(), isInput: true, hint: assignee),
      FormInputField(notes, hint: notesHint, maxLines: true),
      MyButton(label: createAssignment, onPressed: () {})
    ]);
  }
}
