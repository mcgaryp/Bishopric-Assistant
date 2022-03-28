import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

///
/// assignment_card.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/3/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

abstract class AssignmentCard extends StatelessWidget {
  final Assignment assignment;

  const AssignmentCard(this.assignment);

  List<Widget> children(BuildContext context);

  BoxDecoration? get decoration;

  @override
  Widget build(BuildContext context) {
    return MyCard(
        decoration: decoration,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children(context)));
  }
}

class DefaultAssignmentCard extends AssignmentCard {
  final void Function() toggle;

  DefaultAssignmentCard(Assignment assignment, this.toggle)
      : assert(assignment.isNotArchived),
        super(assignment);

  @override
  List<Widget> children(BuildContext context) {
    Authorization currentUserPermissions =
        StateContainer.of(context).member.role.authorization;
    return [
      AssignmentTitle(assignment, toggle: toggle),
      CardRow(sAssignee, content: assignment.assignee.name.fullName),
      if (assignment.note.canView(currentUserPermissions) &&
          assignment.note.content.isNotEmpty)
        CardColumn(sNotes, content: assignment.note.content),
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
            style: MyButtonStyle.errorText,
          ),
          assignment.isCompleted
              ? AssignmentComplete()
              : AssignmentIncomplete(),
        ],
      ),
    ];
  }

  @override
  BoxDecoration? get decoration => null;
}
