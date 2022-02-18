import 'package:bishop_assistant_web_test_app/repositories/firebase_assignment_repo.dart';
import 'package:bishop_assistant_web_test_app/repositories/firebase_member_repository.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// create_assignment_card.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/4/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class CreateAssignmentCard extends StatefulWidget {
  final void Function()? onSave;

  const CreateAssignmentCard({Key? key, this.onSave}) : super(key: key);

  @override
  _CreateAssignmentCardState createState() => _CreateAssignmentCardState();
}

class _CreateAssignmentCardState extends State<CreateAssignmentCard> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  DateTime dueDate = DateTime.now();
  Assignee? assignee;
  Permissions? permissions;

  @override
  Widget build(BuildContext context) {
    AllAssigneesUseCase useCase =
        DefaultAllAssigneesUseCase(FirebaseMemberRepository());

    return MyCard(
        child: Form(
      child: Wrap(runSpacing: 8, children: [
        InputField.plain(sAssignmentTitle, controller: title),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sDueDate, style: subhead),
            CardDateTimeRow(
              (DateTime newDueDate) {
                setState(() {
                  dueDate = newDueDate;
                });
              },
            ),
          ],
        ),
        FutureBuilder<List<Assignee>>(
            future: useCase.execute(StateContainer.of(context).organization.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Assignee> assignees = snapshot.data!;
                return MyDropdown(
                  hint: sAssignee,
                  onchange: (int value) {
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
        MyDropdown(
          hint: sNotesViewPermission,
          onchange: (int value) {
            setState(() {
              permissions = Permissions.values[value];
            });
          },
          collection: Permissions.values
              .map<DropdownMenuItem<int>>((Permissions p) =>
                  DropdownMenuItem(child: Text(p.name), value: p.index))
              .toList(),
        ),
        InputField.plain(sNotes, maxLines: true, controller: content),
        Align(
          alignment: Alignment.centerRight,
          child: MyButton(isExpanded: false, label: sCreate, onPressed: _save),
        )
      ]),
    ));
  }

  void _save() async {
    try {
      if (assignee == null)
        throw FailedToSaveError(reason: "Assignee is not selected");
      if (permissions == null)
        throw FailedToSaveError(reason: "Note Permissions is not selected");
      CreateAssignmentUseCase useCase = DefaultCreateAssignmentUseCase(
          FirebaseAssignmentRepo(), FirebaseMemberRepository());

      MemberID memberID = StateContainer.of(context).member.id;

      Note note = Note(content: content.text, permissions: permissions!);

      Assignment assignment = await useCase.execute(
        title: title.text,
        dueDate: dueDate,
        assignee: assignee!,
        memberID: memberID,
        note: note,
      );
      if (widget.onSave != null) widget.onSave!();
      MyToast.toastSuccess("Successfully saved ${assignment.title}");
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }
  }
}
