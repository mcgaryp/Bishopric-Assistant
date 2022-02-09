import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization_domain/permissions.dart';

///
/// edit_assignment_card.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/4/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class EditAssignmentCard extends StatefulWidget {
  final Assignment assignment;
  final void Function() toggle;

  const EditAssignmentCard(this.assignment, this.toggle, {Key? key})
      : super(key: key);

  @override
  _EditAssignmentCardState createState() => _EditAssignmentCardState();
}

class _EditAssignmentCardState extends State<EditAssignmentCard> {
  @override
  Widget build(BuildContext context) {
    Permissions currentUserPermissions =
        StateContainer.of(context).member.role.permissions;

    return MyCard(
        child: Form(
            child: Wrap(children: [
      InputField.border(widget.assignment.title),
      Text(sDueDate, style: body),
      CardDateTimeRow((DateTime newDate) {}),
      MyDropdown(
        hint: widget.assignment.assignee.name.fullName,
      ),
      if (widget.assignment.note.canView(currentUserPermissions))
        Text(sNotes, style: subhead),
      if (widget.assignment.note.canView(currentUserPermissions))
        InputField.plain(widget.assignment.note.content, maxLines: true),
      Align(
        alignment: Alignment.centerRight,
        child: MyButton(
            isExpanded: false,
            label: sSave,
            onPressed: () {
              // TODO: Update Assignment Use Case
              widget.toggle();
            }),
      ),
    ])));
  }
}
