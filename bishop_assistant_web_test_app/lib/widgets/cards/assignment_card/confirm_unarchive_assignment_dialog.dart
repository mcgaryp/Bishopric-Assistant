import 'package:bishop_assistant_web_test_app/firebase/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models/assignment.dart';

///
/// confirm_unarchive_assignment_dialog.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/10/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class ConfirmUnarchiveAssignmentDialog extends StatelessWidget {
  final String name;
  final AssignmentID assignmentID;

  const ConfirmUnarchiveAssignmentDialog(
      {required this.name, required this.assignmentID, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialog(
        onConfirm: () async {
          try {
            UnarchiveAssignmentUseCase useCase =
                DefaultUnarchiveAssignmentUseCase(FirestoreMemberRepository(),
                    FirestoreAssignmentRepository());
            bool isUnarchived = await useCase.execute(
                memberID: StateContainer.of(context).member.id,
                assignmentID: assignmentID);
            if (isUnarchived) {
              MyToast.toastSuccess("Successfully unarchived $name");
              Navigator.pop(context);
            }
          } catch (error) {
            if (kDebugMode) print(error);
            MyToast.toastError(error);
          }
        },
        title: sConfirmUnarchive,
        content: "Are you sure you would like to unarchive '$name'? Doing so "
            "will allow others to view and also edit this assignment.");
  }
}
