import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/assignment_domain/assignment.dart';
import 'package:models/models/organization_domain/permissions.dart';

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
    Permissions currentUserPermissions =
        StateContainer.of(context).member.role.permissions;

    return [
      AssignmentTitle.light(assignment, toggle: toggle),
      CardRow.light(sAssignee, content: assignment.assignee.name.fullName),
      if (assignment.note.canView(currentUserPermissions) &&
          assignment.note.content.isNotEmpty)
        CardColumn.light(sNotes, content: assignment.note.content),
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
              ? AssignmentComplete()
              : AssignmentIncomplete.isLight(),
        ],
      ),
    ];
  }

  @override
  BoxDecoration? get decoration => floatingErrorRedBox;
}
