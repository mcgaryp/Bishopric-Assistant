import 'package:bishop_assistant_web_test_app/firebase/repositories/firebase_assignment_repo.dart';
import 'package:bishop_assistant_web_test_app/firebase/repositories/firebase_member_repository.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models/assignment.dart';

///
/// confirm_delete_assignment_dialog.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/4/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class ConfirmDeleteAssignmentDialog extends StatelessWidget {
  final String name;
  final AssignmentID assignmentID;

  const ConfirmDeleteAssignmentDialog(
      {required this.name, required this.assignmentID, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialog(
      onConfirm: () async {
        try {
          DeleteAssignmentUseCase useCase = DefaultDeleteAssignmentUseCase(
              FirebaseAssignmentRepo(), FirebaseMemberRepository());
          bool didDelete = await useCase.execute(
              assignmentID: assignmentID,
              memberID: StateContainer.of(context).member.id);
          if (didDelete) {
            MyToast.toastSuccess("Successfully deleted $name");
            Navigator.pop(context);
          }
        } catch (error) {
          if (kDebugMode) print(error);
          MyToast.toastError(error);
        }
      },
      title: sConfirmDelete,
      content: "Are you sure you would like to delete '$name'? Doing so will "
          "delete all assignment information forever",
    );
  }
}
