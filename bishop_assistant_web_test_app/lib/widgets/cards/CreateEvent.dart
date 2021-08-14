import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseDropDown.dart';
import 'package:bishop_assistant_web_test_app/widgets/FormInputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MultiSelectField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/RowToggle.dart';
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

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  var _selectedMembers = [];

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
      // TODO: Turn into MultiSelect options
      //    look at https://pub.dev/packages/multi_select_flutter
      MultiSelectField(assignees),
      // FirebaseDropDown(
      //     collectionPath: Collections.members,
      //     document: MembersDoc(),
      //     isInput: true),
      FormInputField(
        agenda,
        hint: agendaHint,
      ),
      FormInputField(
        notes,
        hint: notesHint,
      ),
      // TODO: create a custom switch item
      RowToggle(notifyAssignee),
      RowToggle(notifyInterviewee),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            notifyWhen,
            style: bodyStyle,
            maxLines: 2,
            softWrap: true,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 100),
            child: FormInputField(
              time,
              hint: DateFormat.j().format(DateTime.now()),
            ),
          )
        ],
      ),
      MyButton(label: createEvent, onPressed: () {/*TODO*/})
    ]);
  }
}
