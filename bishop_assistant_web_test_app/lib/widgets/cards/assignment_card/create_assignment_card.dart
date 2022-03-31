import 'package:bishop_assistant_web_test_app/firebase/repositories/repositories.dart';
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
  Role? assignee;
  List<Role> viewers = [];

  bool editable = true;
  bool reassignable = true;

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Form(
      child: Wrap(runSpacing: 8, children: [
        // Assignment Title
        InputField.plain(sAssignmentTitle, controller: title),
        // Assignment Due Date
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

        // Assignment Notes
        InputField.plain(sNotes, maxLines: true, controller: content),

        // Assignment is Editable by others
        RowToggle(
          "Editable by Others",
          value: editable,
          onChanged: (bool value) {
            setState(() {
              editable = value;
            });
          },
        ),

        // Assignment is Reassignable by others
        RowToggle(
          "Reassignable by Others",
          value: reassignable,
          onChanged: (bool value) {
            setState(() {
              reassignable = value;
            });
          },
        ),

        // Visible to
        MyMultiSelectField<Role>(
          "Visible to...",
          onChange: (List<Role> lst) {
            setState(() {
              viewers = lst;
            });
          },
          items: items,
        ),

        // Assigned to
        MyDropdown(
          hint: "Assigned to...",
          onchange: (int? value) {
            setState(() {
              assignee = StateContainer.of(context)
                  .roles
                  .firstWhere((Role r) => r.id.id.hashCode == value);
            });
          },
          collection: collection,
        ),

        // Save
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

      CreateAssignmentUseCase useCase = DefaultCreateAssignmentUseCase(
          FirestoreAssignmentRepository(), FirestoreMemberRepository());

      MemberID memberID = StateContainer.of(context).member.id;

      if (await useCase.execute(
        title: title.text,
        dueDate: dueDate,
        assignee: assignee!,
        memberID: memberID,
        note: content.text,
        editable: editable,
        viewers: viewers,
        reassignable: reassignable,
      )) {
        if (widget.onSave != null) widget.onSave!();
        MyToast.toastSuccess("Successfully saved ${title.text}");
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }
  }

  List<MultiSelectItem<Role>> get items {
    return StateContainer.of(context)
        .roles
        .map<MultiSelectItem<Role>>((Role r) {
      return MultiSelectItem<Role>(
        r,
        r.name,
      );
    }).toList();
  }

  List<DropdownMenuItem<int>> get collection => StateContainer.of(context)
      .roles
      .map<DropdownMenuItem<int>>((Role r) => DropdownMenuItem<int>(
          value: r.id.id.hashCode, child: Text(r.name, style: body)))
      .toList();
}
