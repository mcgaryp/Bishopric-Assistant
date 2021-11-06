import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Event.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/EventType.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/MemberEvents.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/OrganizationEvents.dart';
import 'package:bishop_assistant_web_test_app/util/MyToast.dart';
import 'package:bishop_assistant_web_test_app/util/Validators.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardDateTimeRow.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/firebase_drop_down.dart';
import 'package:bishop_assistant_web_test_app/widgets/firebase_multi_select_field.dart';
import 'package:bishop_assistant_web_test_app/widgets/my_button.dart';
import 'package:flutter/material.dart';

///
/// CreateEvent.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

/// Properly creates an event and stores it in the database
class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  // Global Key for the form
  final _formKey = GlobalKey<FormState>();

  // Text Editing Controllers
  TextEditingController nameControl = TextEditingController();
  TextEditingController locationControl = TextEditingController();
  TextEditingController agendaControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();
  TextEditingController intervieweeControl = TextEditingController();

  // Specific fields for events
  DateTime _selectedDateTime = DateTime.now();
  List<OldMember> _selectedAssignees = [];
  EventType _selectedEventType = EventType.none;

  // Util to establish proper state management of widget
  bool _isWaiting = false;
  int _counter = 0;

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
      // RowToggle(notifyAssignee),
      // RowToggle(notifyInterviewee),
      // CardTextFieldRow(notifyWhen,
      //     secondLabel: hours, hint: DateFormat.j().format(DateTime.now())),
      AbsorbPointer(
        absorbing: _isWaiting,
        child: MyButton(label: createEvent, onPressed: _onPress),
      )
    ]);
  }

  /// Updates the selected time and date
  void _onDateTimeChange(DateTime time) {
    setState(() {
      _selectedDateTime = time;
    });
  }

  /// Updates the state of the Waiting variable
  void _setIsWaiting(bool val) {
    setState(() {
      _isWaiting = val;
    });
  }

  /// Updates the List of Assigned members
  Future<void> _onAssigneesChange(list) async {
    // Prevent user from selecting the create button
    _setIsWaiting(true);
    List<OldMember> assignees = [];

    // Create the list of members
    for (FirestoreDocument document in list) {
      OldMember member = await OldMember.find(document.id);
      assignees.add(member);
    }

    // Set the variables and allow users to interact with create button
    setState(() {
      _selectedAssignees = assignees;
      _isWaiting = false;
    });
  }

  /// Updates the assigned member
  Future<void> _onAssigneeChange(int memberID) async {
    _setIsWaiting(true);
    OldMember member = await OldMember.find(memberID);

    setState(() {
      _selectedAssignees = [member];
      _isWaiting = false;
    });
  }

  /// Updates the event type
  void _onEventTypeChange(int eventType) {
    setState(() {
      _selectedEventType = ParseEventType.fromID(eventType);
    });
  }

  /// When the create button is pressed add the information to the database
  void _onPress() {
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
      OldFirestoreHelper.addDocument(Collections.events,
          doc: event, error: _error, success: (eventID) async {
        // Tie the Event to the organization
        int organizationID =
            await OrganizationEvents.findOrganizationID(eventID);
        OldFirestoreHelper.addDocument(Collections.organization_events,
            doc: OrganizationEvents(eventID, organizationID),
            error: _error, success: (organizationEventID) async {
          // Tie the Event to the assignees
          for (OldMember member in _selectedAssignees) {
            await OldFirestoreHelper.addDocument(Collections.member_events,
                doc: MemberEvents(member.id, organizationEventID),
                error: _error,
                success: _success);
          }
        });
      });
    } else
      _setIsWaiting(false);
  }

  /// Displays an error when presented
  void _error(error) {
    MyToast.toastError(error);
    _setIsWaiting(false);
  }

  /// Notifies the user that the event has been properly created
  void _success(_) {
    _counter += 1;
    if (_counter == _selectedAssignees.length) {
      MyToast.toastSuccess(created + nameControl.text);
      _setIsWaiting(false);
    }
  }
}
