import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseDropDown.dart';
import 'package:bishop_assistant_web_test_app/widgets/FormInputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MyCard.dart';
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FormInputField(
              date,
              hint: DateFormat.MMMMEEEEd().format(DateTime.now()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: padding8),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 100),
              child: FormInputField(
                time,
                hint: DateFormat.jm().format(DateTime.now()),
              ),
            ),
          ),
        ],
      ),
      FormInputField(
        location,
        hint: locationHint,
      ),
      FirebaseDropDown(
          collectionPath: Collections.event_types,
          document: EventTypesDoc(),
          isInput: true),
      FirebaseDropDown(
          collectionPath: Collections.members,
          document: MembersDoc(),
          isInput: true),
      FormInputField(
        agenda,
        hint: agendaHint,
      ),
      FormInputField(
        notes,
        hint: notesHint,
      ),
      // TODO: create a custom switch item
      Switch(value: false, onChanged: (value) {})
    ]);
  }
}
