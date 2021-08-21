import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:bishop_assistant_web_test_app/database/models/Assignment.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/util/Validators.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseDropDown.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardDateTimeRow.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///
/// CreateAssignment.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/15/21
/// Copyright 2021 Po. All rights reserved.
///

// TODO: Comment
class CreateAssignment extends StatefulWidget {
  const CreateAssignment({Key? key}) : super(key: key);

  @override
  _CreateAssignmentState createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();

  bool _isWaiting = false;
  // TODO: Use as the member ID?
  String? _selectedMember;
  DateTime _selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [
      // TODO: Create validation for assignments
      Form(
        key: _formKey,
        child: Column(
          children: [
            InputField.border(assignmentName,
                hint: assignmentNameHint,
                controller: nameControl,
                validator: Validators.standard),
            CardDateTimeRow(_onDateTimeUpdate),
            FirebaseDropDown(
              collectionPath: Collections.members,
              document: MembersDoc(),
              isInput: true,
              hint: assignee,
              onchange: _onChange,
              validator: Validators.validateDropDown,
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
      AbsorbPointer(
        absorbing: _isWaiting,
        child: MyButton(
            label: createAssignment,
            onPressed: () {
              _setIsWaiting(true);

              // Validate form
              if (_formKey.currentState!.validate()) {
                Assignment assignment = Assignment(-1, nameControl.text,
                    _selectedDateTime, Member.bishopExample,
                    notes: notesControl.text);

                // Add assignment to database
                // TODO: Assignee to the Assignment
                // TODO: Return the ID of the new document?
                FirestoreHelper.addDocument(Collections.assignments,
                    doc: AssignmentsDoc(), model: assignment, error: (error) {
                  Fluttertoast.showToast(
                      msg: error.toString(), timeInSecForIosWeb: 5);
                  _setIsWaiting(false);
                }, success: () {
                  Fluttertoast.showToast(
                      msg: "${assignment.name} Created", timeInSecForIosWeb: 2);
                  _setIsWaiting(false);
                });
              } else
                _setIsWaiting(false);
            }),
      )
    ]);
  }

  _onDateTimeUpdate(DateTime time) {
    setState(() {
      _selectedDateTime = time;
      print(_selectedDateTime);
    });
  }

  // TODO: Change to member ID
  _onChange(memberName) {
    setState(() {
      _selectedMember = memberName;
    });
  }

  _setIsWaiting(bool val) {
    setState(() {
      _isWaiting = val;
    });
  }
}
