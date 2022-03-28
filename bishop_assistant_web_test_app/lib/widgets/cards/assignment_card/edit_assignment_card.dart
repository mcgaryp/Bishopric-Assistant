import 'package:bishop_assistant_web_test_app/firebase/new_repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
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
  late Assignee assignee;

  @override
  void initState() {
    selectedDate = widget.assignment.dueDate;
    assignee = widget.assignment.assignee;
    notes = TextEditingController.fromValue(
        TextEditingValue(text: widget.assignment.note.content));
    title = TextEditingController.fromValue(
        TextEditingValue(text: widget.assignment.title));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Authorization currentUserPermissions =
        StateContainer.of(context).member.role.authorization;

    AllAssigneesUseCase useCase =
        DefaultAllAssigneesUseCase(FirestoreMemberRepository());

    return MyCard(
        child: Form(
            child: Wrap(children: [
      InputField.plain(widget.assignment.title, controller: title),
      Text(sDueDate, style: body),
      CardDateTimeRow((DateTime newDate) {
        setState(() {
          selectedDate = newDate;
        });
      }, initialDateTime: selectedDate),
      FutureBuilder<List<Assignee>>(
          future: useCase.execute(StateContainer.of(context).organization.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Assignee> assignees = snapshot.data!;
              return MyDropdown(
                hint: widget.assignment.assignee.name.fullName,
                onchange: (int? value) {
                  for (Assignee element in assignees) {
                    if (element.id.id.hashCode == value) {
                      setState(() {
                        assignee = element;
                      });
                      break;
                    }
                  }
                },
                collection: assignees
                    .map<DropdownMenuItem<int>>((Assignee assignee) =>
                        DropdownMenuItem(
                            child: Text(assignee.name.fullName),
                            value: assignee.id.id.hashCode))
                    .toList(),
              );
            }
            return SpinKitThreeBounce(size: 25, color: dark);
          }),
      if (widget.assignment.note.canView(currentUserPermissions))
        Text(sNotes, style: subhead),
      if (widget.assignment.note.canView(currentUserPermissions))
        InputField.plain(widget.assignment.note.content,
            maxLines: true, controller: notes),
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
      );

      return result;
    } catch (error) {
      if (kDebugMode) print(error);
      MyToast.toastError(error);
    }

    return false;
  }
}
