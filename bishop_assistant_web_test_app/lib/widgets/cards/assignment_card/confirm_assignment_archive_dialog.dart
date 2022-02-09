import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';

///
/// confirm_assignment_archive_dialog.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/4/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class ConfirmAssignmentArchiveDialog extends StatelessWidget {
  final String name;

  const ConfirmAssignmentArchiveDialog(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialog(
        onConfirm: () {
          // TODO: Archive Assignment UseCase
        },
        title: sConfirmArchive,
        content: "Are you sure you want to archive '$name'? Doing so will not "
            "allow any member of the organization to change or "
            "edit the assignment, unless it is unarchived.\n\n**Regular viewing "
            "permissions will continue to safe guard the Assignments private "
            "information.**");
  }
}
