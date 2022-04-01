import 'package:the_assistant/firebase/repositories/repositories.dart';
import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

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
  late TextEditingController title;
  late TextEditingController notes;
  late DateTime selectedDate;
  late Role assignee;
  late bool reassignable;
  late bool editable;
  late Member currentUser;
  late List<Role> viewers;

  @override
  void initState() {
    selectedDate = widget.assignment.dueDate;
    assignee = widget.assignment.assignee;
    notes = TextEditingController.fromValue(
        TextEditingValue(text: widget.assignment.note));
    title = TextEditingController.fromValue(
        TextEditingValue(text: widget.assignment.title));
    reassignable = widget.assignment.reassignable;
    editable = widget.assignment.editable;
    viewers = widget.assignment.viewers;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentUser = StateContainer.of(context).member;

    return MyCard(
        child: Form(
            child: Wrap(children: [
      // Title
      InputField.plain(widget.assignment.title,
          label: sAssignmentTitle, controller: title),

      // Due Date
      Text(sDueDate, style: subhead),
      CardDateTimeRow(
        (DateTime newDate) {
          setState(() {
            selectedDate = newDate;
          });
        },
        initialDateTime: selectedDate,
      ),

      // Notes
      InputField.plain(widget.assignment.note,
          label: sNotes, maxLines: true, controller: notes),

      // Editable
      if (isCreator)
        RowToggle(
          "Editable",
          value: editable,
          onChanged: (bool val) {
            setState(() {
              editable = val;
            });
          },
        ),

      // Reassignable
      if (isCreator)
        RowToggle("Reassignable", value: reassignable, onChanged: (bool val) {
          setState(() {
            reassignable = val;
          });
        }),

      // Assigned to
      if (widget.assignment.reassignable || editable || isCreator)
        MyDropdown(
          hint: "Assigned to...",
          onchange: (lst) {},
          collection: collection,
          initialValue: assignee.id.id.hashCode,
        ),

      // Visible to
      if (widget.assignment.reassignable || reassignable || isCreator)
        MyMultiSelectField<Role>(
          "Visible to...",
          onChange: (lst) {},
          items: items,
          initialValues: viewers,
        ),

      // Save or Cancel
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyButton(
            isExpanded: false,
            label: sCancel,
            onPressed: widget.toggle,
            style: MyButtonStyle.text,
          ),
          MyButton(
              isExpanded: false,
              label: sSave,
              onPressed: () async {
                if (await _update()) {
                  widget.toggle();
                }
              }),
        ],
      ),
    ])));
  }

  Future<bool> _update() async {
    try {
      UpdateAssignmentUseCase useCase = DefaultUpdateAssignmentUseCase(
          FirestoreAssignmentRepository(), FirestoreMemberRepository());

      bool result = await useCase.execute(
        assignmentID: widget.assignment.id,
        memberID: StateContainer.of(context).member.id,
        title: title.text,
        dueDate: selectedDate,
        assignee: assignee,
        noteContent: notes.text,
        editable: editable,
        reassignable: reassignable,
        viewers: viewers,
      );

      return result;
    } catch (error) {
      if (kDebugMode) print(error);
      MyToast.toastError(error);
    }

    return false;
  }

  List<MultiSelectItem<Role>> get items {
    return StateContainer.of(context)
        .roles
        .map<MultiSelectItem<Role>>(
            (Role role) => MultiSelectItem(role, role.name))
        .toList();
  }

  List<DropdownMenuItem<int>> get collection {
    return StateContainer.of(context)
        .roles
        .map<DropdownMenuItem<int>>((Role role) => DropdownMenuItem(
            value: role.id.id.hashCode, child: Text(role.name, style: body)))
        .toList();
  }

  bool get isCreator => widget.assignment.creator == currentUser.role;
}
