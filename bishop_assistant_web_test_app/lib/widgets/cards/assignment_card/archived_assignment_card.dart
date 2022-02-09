import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/assignment.dart';

///
/// archived_assignment_card.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/4/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class ArchivedAssignmentCard extends AssignmentCard {
  ArchivedAssignmentCard(Assignment assignment)
      : assert(assignment.isArchived),
        super(assignment);

  @override
  List<Widget> children(BuildContext context) => [
        AssignmentTitle(assignment),
        CardRow(sAssignee, content: assignment.assignee.name.fullName),
        CardColumn(sNotes, content: assignment.note.content),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyButton(
                isExpanded: false,
                style: MyButtonStyle.text,
                label: sUnarchive,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          ConfirmUnarchiveAssignmentDialog(assignment.title));
                }),
            MyButton(
                isExpanded: false,
                style: MyButtonStyle.errorText,
                label: sDelete,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          ConfirmDeleteAssignmentDialog(assignment.title));
                }),
            Spacer(),
            assignment.isCompleted
                ? AssignmentComplete()
                : AssignmentIncomplete.isArchived(),
          ],
        ),
      ];

  @override
  BoxDecoration? get decoration => floatingWarningBox;
}

class ConfirmUnarchiveAssignmentDialog extends StatelessWidget {
  final String name;

  const ConfirmUnarchiveAssignmentDialog(this.name, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialog(
        onConfirm: () {
          // TODO: Unarchive UseCase
        },
        title: sConfirmUnarchive,
        content:
            "Are you sure you would like to unarchive '$name'? Doing so will allow others to view and also edit this assignment.");
  }
}
