import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseDropDown.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseMultiSelectField.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
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

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {

  DateTime _selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [
      // TODO: Add validation to items
      InputField.border(
        eventName,
        hint: eventNameHint,
      ),
      CardDateTimeRow(_onDateTimeChange),
      InputField.border(
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
      InputField.border(
        agenda,
        hint: agendaHint,
        maxLines: true,
      ),
      InputField.border(
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

  _onDateTimeChange(DateTime time) {
    setState(() {
      _selectedDateTime = time;
    });
  }
}
