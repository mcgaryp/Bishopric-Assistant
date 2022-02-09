import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';

///
/// confirm_delete_assignment_dialog.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/4/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class ConfirmDeleteAssignmentDialog extends StatelessWidget {
  final String name;

  const ConfirmDeleteAssignmentDialog(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialog(
      onConfirm: () => {
        // TODO: Delete Assignment UseCase
      },
      title: sConfirmDelete,
      content: "Are you sure you would like to delete '$name'? Doing so will "
          "delete all assignment information forever",
    );
  }
}
