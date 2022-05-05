import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/assignment_domain/assignment.dart';

///
/// over_due_assignment_card.dart
/// bishopric-assistant
///
/// Created by Po on 2/7/22
/// Copyright 2022 Po. All rights reserved.
///

class OverDueAssignmentCard extends AssignmentCard {
  final void Function() toggle;

  OverDueAssignmentCard(Assignment assignment, this.toggle) : super(assignment);

  @override
  List<Widget> children(BuildContext context) {
    return [
      AssignmentTitle.light(assignment, toggle: toggle),
      CardRow.light(sAssignee, content: assignment.assignee.name),
      CardColumn.light(sNotes, content: assignment.note),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyButton(
            isExpanded: false,
            label: sArchive,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (dialogCon) => ConfirmAssignmentArchiveDialog(
                      name: assignment.title, assignmentID: assignment.id));
            },
            style: MyButtonStyle.lightText,
          ),
          assignment.isCompleted
              ? AssignmentComplete.isOverDue(assignmentID: assignment.id)
              : AssignmentIncomplete.isLight(assignmentID: assignment.id),
        ],
      ),
    ];
  }

  @override
  BoxDecoration? get decoration => floatingErrorRedBox;
}
