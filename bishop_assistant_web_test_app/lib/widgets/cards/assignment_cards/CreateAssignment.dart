import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Assignment.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/MemberAssignments.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/OrganizationAssignment.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/OrganizationMembers.dart';
import 'package:bishop_assistant_web_test_app/util/MyToast.dart';
import 'package:bishop_assistant_web_test_app/util/Validators.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardDateTimeRow.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/firebase_drop_down.dart';
import 'package:bishop_assistant_web_test_app/widgets/my_button.dart';
import 'package:flutter/material.dart';

///
/// CreateAssignment.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/15/21
/// Copyright 2021 Po. All rights reserved.
///

/// Widget draws and handles the state of creating an Assignment
class CreateAssignment extends StatefulWidget {
  const CreateAssignment({Key? key}) : super(key: key);

  @override
  _CreateAssignmentState createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  // Used to identify the form
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers for form input
  TextEditingController nameControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();

  // Is the widget waiting for a callback to complete
  bool _isWaiting = false;

  // The assigned member to complete the Assignment
  OldMember? _selectedMember;

  // Selected due date of the assignment
  DateTime _selectedDateTime = DateTime.now();

  // The assignment details
  Assignment? assignment;

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [
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
              isInput: true,
              hint: assignee,
              onchange: _onAssigneeChange,
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
          child: MyButton(label: createAssignment, onPressed: _onPress))
    ]);
  }

  /// Updates the dateTime variable
  void _onDateTimeUpdate(DateTime time) {
    setState(() {
      _selectedDateTime = time;
      print(_selectedDateTime);
    });
  }

  /// Updates the selected assignee for the assignment
  void _onAssigneeChange(int memberID) async {
    OldMember member = await OldMember.find(memberID);
    setState(() {
      _selectedMember = member;
    });
  }

  /// Updates the is waiting on a callback
  void _setIsWaiting(bool val) {
    setState(() {
      _isWaiting = val;
    });
  }

  /// When the submit button is pressed the following occurs
  /// 1. Notify we need to wait
  /// 2. Validate
  /// 3. Create the assignment
  /// 4. Tie the assignment to an organization
  /// 5. Tie the assignment to the member in the organization
  _onPress() {
    _setIsWaiting(true);

    // Validate form
    if (_formKey.currentState!.validate()) {
      // Create assignment
      assignment = Assignment.create(nameControl.text,
          dateTime: _selectedDateTime,
          assignee: _selectedMember!,
          notes: notesControl.text);

      // Add assignment to database
      OldFirestoreHelper.addDocument(Collections.assignments,
          doc: assignment!, error: _error, success: _tieOrganization);
    } else
      _setIsWaiting(false);
  }

  /// Ties the organization to the assignment
  Future<void> _tieOrganization(int assignmentID) async {
    // Get organizationID from assignee
    int organizationID =
        await OrganizationMembers.findOrganizationID(assignment!.assignee.id);

    // Tie assignment to organization
    OldFirestoreHelper.addDocument(Collections.organization_assignments,
        doc: OrganizationAssignments(assignmentID, organizationID),
        error: _error,
        success: _tieAssignee);
  }

  /// Ties the Assignee to the Assignment
  void _tieAssignee(int organizationAssignmentID) {
    // Get selected member ID
    int memberID = assignment!.assignee.id;

    // Tie assignment to assignee
    OldFirestoreHelper.addDocument(Collections.member_assignments,
        doc: MemberAssignments(memberID, organizationAssignmentID),
        error: _error,
        success: _success);
  }

  /// Should the process be completed then notify the user
  void _success(int memberOrganizationAssignmentID) {
    MyToast.toastSuccess(created + nameControl.text);
    _setIsWaiting(false);
  }

  /// Should the process fail notify the user
  void _error(error) {
    MyToast.toastError(error);
    _setIsWaiting(false);
  }
}
