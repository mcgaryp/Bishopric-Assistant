import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseDropDown.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseMultiSelectField.dart';
import 'package:bishop_assistant_web_test_app/widgets/FormInputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/RowToggle.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardDateTimeRow.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardTextFieldRow.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      CardDateTimeRow(),
      FormInputField(
        location,
        hint: locationHint,
      ),
      FirebaseDropDown(
          hint: eventType,
          collectionPath: Collections.event_types,
          document: EventTypesDoc(),
          isInput: true),
      FirebaseMultiSelectField(assignees,
          collectionPath: Collections.members, document: MembersDoc()),
      FormInputField(
        agenda,
        hint: agendaHint,
        maxLines: true,
      ),
      FormInputField(
        notes,
        hint: notesHint,
        maxLines: true,
      ),
      RowToggle(notifyAssignee),
      RowToggle(notifyInterviewee),
      CardTextFieldRow(notifyWhen,
          secondLabel: hours, hint: DateFormat.j().format(DateTime.now())),
      MyButton(
          label: createEvent,
          onPressed: () {
            /*TODO*/
          })
    ]);
  }
}
