import 'package:bishop_assistant_web_test_app/firebase/new_repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models/assignment.dart';

///
/// confirm_assignment_archive_dialog.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/4/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class ConfirmAssignmentArchiveDialog extends StatelessWidget {
  final String name;
  final AssignmentID assignmentID;

  const ConfirmAssignmentArchiveDialog(
      {required this.name, required this.assignmentID, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialog(
        onConfirm: () async {
          try {
            ArchiveAssignmentUseCase useCase = DefaultArchiveAssignmentUseCase(
                FirestoreMemberRepository(), FirestoreAssignmentRepository());
            bool movedToArchive = await useCase.execute(
                memberID: StateContainer.of(context).member.id,
                assignmentID: assignmentID);
            if (movedToArchive) {
              MyToast.toastSuccess("$name has been Archived");
              Navigator.pop(context);
            }
          } catch (error) {
            if (kDebugMode) print(error);
            MyToast.toastError(error);
          }
        },
        title: sConfirmArchive,
        content: "Are you sure you want to archive '$name'? Doing so will not "
            "allow any member of the organization to change or "
            "edit the assignment, unless it is unarchived.\n\n**Regular viewing "
            "permissions will continue to safe guard the Assignments private "
            "information.**");
  }
}
