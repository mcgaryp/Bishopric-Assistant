import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:bishop_assistant_web_test_app/database/models/Event.dart';
import 'package:bishop_assistant_web_test_app/database/models/EventType.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/database/models/MemberEvents.dart';
import 'package:bishop_assistant_web_test_app/database/models/OrganizationEvents.dart';
import 'package:bishop_assistant_web_test_app/util/MyToast.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/util/Validators.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseDropDown.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseMultiSelectField.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardDateTimeRow.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:flutter/material.dart';

///
/// CreateEvent.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

// TODO: Comments
class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameControl = TextEditingController();
  TextEditingController locationControl = TextEditingController();
  TextEditingController agendaControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();
  TextEditingController intervieweeControl = TextEditingController();

  DateTime _selectedDateTime = DateTime.now();

  List<Member> _selectedAssignees = [];

  bool _isWaiting = false;

  EventType _selectedEventType = EventType.none;

  int numberOfAssignees = -1;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [
      Form(
        key: _formKey,
        child: Column(
          children: [
            InputField.border(
              eventName,
              hint: eventNameHint,
              validator: Validators.standard,
              controller: nameControl,
            ),
            CardDateTimeRow(_onDateTimeChange),
            InputField.border(
              location,
              hint: locationHint,
              validator: Validators.standard,
              controller: locationControl,
            ),
            FirebaseDropDown(
              hint: eventType,
              collectionPath: Collections.event_types,
              isInput: true,
              onchange: _onEventTypeChange,
              validator: Validators.validateDropDown,
            ),
            if (_selectedEventType == EventType.interview)
              FirebaseDropDown(
                hint: assignee,
                collectionPath: Collections.members,
                isInput: true,
                onchange: _onAssigneeChange,
                validator: Validators.validateDropDown,
              ),
            if (_selectedEventType == EventType.interview)
              InputField.border(
                interviewee,
                hint: intervieweeHint,
                controller: intervieweeControl,
                validator: Validators.standard,
              ),
            if (_selectedEventType == EventType.meeting)
              FirebaseMultiSelectField(assignees,
                  collectionPath: Collections.members,
                  onChange: _onAssigneesChange,
                  validator: Validators.validateMultiSelect),
            if (_selectedEventType == EventType.meeting)
              InputField.border(
                agenda,
                hint: agendaHint,
                maxLines: true,
                controller: agendaControl,
                validator: Validators.standard,
              ),
            InputField.border(
              notes,
              hint: notesHint,
              maxLines: true,
              controller: notesControl,
            ),
          ],
        ),
      ),
      // TODO: Implement Notifications and Alerts to support 78 to 81
      // RowToggle(notifyAssignee),
      // RowToggle(notifyInterviewee),
      // CardTextFieldRow(notifyWhen,
      //     secondLabel: hours, hint: DateFormat.j().format(DateTime.now())),
      AbsorbPointer(
        absorbing: _isWaiting,
        child: MyButton(
            label: createEvent,
            onPressed: () {
              _setIsWaiting(true);

              // Validate form
              if (_formKey.currentState!.validate()) {
                // Create Even Object
                Event event;
                if (_selectedEventType == EventType.interview) {
                  event = Interview.create(
                    nameControl.text,
                    dateTime: _selectedDateTime,
                    interviewee: intervieweeControl.text,
                    assignee: _selectedAssignees.first,
                    notes: notesControl.text,
                  );
                } else {
                  event = Meeting.create(nameControl.text,
                      dateTime: _selectedDateTime,
                      agenda: agendaControl.text,
                      assignees: _selectedAssignees,
                      location: locationControl.text,
                      notes: notesControl.text);
                }

                // Add Event object to the database
                FirestoreHelper.addDocument(Collections.events,
                    doc: event, error: _error, success: (eventID) async {
                  // Tie the Event to the organization
                  int organizationID =
                      await OrganizationEvents.findOrganizationID(eventID);
                  FirestoreHelper.addDocument(Collections.organization_events,
                      doc: OrganizationEvents(eventID, organizationID),
                      error: _error, success: (organizationEventID) async {
                    // Tie the Event to the assignees
                    for (Member member in _selectedAssignees) {
                      await FirestoreHelper.addDocument(Collections.member_events,
                          doc: MemberEvents(member.id, organizationEventID),
                          error: _error,
                          success: _success);
                    }
                  });
                });
              } else
                _setIsWaiting(false);
            }),
      )
    ]);
  }

  // Updates the selected time and date
  void _onDateTimeChange(DateTime time) {
    setState(() {
      _selectedDateTime = time;
    });
  }

  // Updates the state of the Waiting variable
  void _setIsWaiting(bool val) {
    setState(() {
      _isWaiting = val;
    });
  }

  // Updates the List of Assigned members
  Future<void> _onAssigneesChange(list) async {
    _setIsWaiting(true);
    List<Member> assignees = [];

    for (FirestoreDocument document in list) {
      Member member = await Member.find(document.id);
      assignees.add(member);
    }

    setState(() {
      _selectedAssignees = assignees;
      _isWaiting = false;
    });
  }

  // Updates the assigned member
  Future<void> _onAssigneeChange(int memberID) async {
    _setIsWaiting(true);
    Member member = await Member.find(memberID);

    setState(() {
      _selectedAssignees = [member];
      _isWaiting = false;
    });
  }

  // TODO: Return event Type ID, this sort of already does this.
  void _onEventTypeChange(int eventType) {
    setState(() {
      _selectedEventType = ParseEventType.fromID(eventType);
    });
  }

  void _error(error) {
    MyToast.toastError(error.toString());
    _setIsWaiting(false);
  }

  void _success(_) {
    counter += 1;
    if (counter == _selectedAssignees.length) {
      MyToast.toastSuccess("Created ${nameControl.text}");
      _setIsWaiting(false);
    }
  }
}
