import 'package:the_assistant/widgets/widgets.dart';
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
        CardRow(sAssignee, content: assignment.assignee.name),
        CardColumn(sNotes, content: assignment.note),
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
                      builder: (context) => ConfirmUnarchiveAssignmentDialog(
                          name: assignment.title, assignmentID: assignment.id));
                }),
            MyButton(
                isExpanded: false,
                style: MyButtonStyle.errorText,
                label: sDelete,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => ConfirmDeleteAssignmentDialog(
                            name: assignment.title,
                            assignmentID: assignment.id,
                          ));
                }),
            Spacer(),
            assignment.isCompleted
                ? AssignmentComplete(assignmentID: assignment.id)
                : AssignmentIncomplete.isArchived(assignmentID: assignment.id),
          ],
        ),
      ];

  @override
  BoxDecoration? get decoration => floatingWarningBox;
}
