import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// create_assignment_view.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/7/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class CreateAssignmentView extends StatefulWidget {
  const CreateAssignmentView({Key? key}) : super(key: key);

  @override
  _CreateAssignmentViewState createState() => _CreateAssignmentViewState();
}

class _CreateAssignmentViewState extends State<CreateAssignmentView> {
  bool isCreating = false;
  late bool isMobile;
  late double width;

  @override
  Widget build(BuildContext context) {
    Authorization currentUserPermissions =
        StateContainer.of(context).member.role.authorization;

    width = MediaQuery.of(context).size.width;
    isMobile = width < 700;

    return ListView(children: [
      SizedBox(height: padding8),
      if (isMobile)
        Padding(
          padding: const EdgeInsets.only(bottom: padding8),
          child: Text(sCreateAssignment, style: title),
        ),
      if (!isCreating && !isMobile && currentUserPermissions.rank >= 0)
        MyButton(
          label: sCreateAssignment,
          onPressed: () {
            setState(() {
              isCreating = true;
            });
          },
          isExpanded: false,
        ),
      if (isCreating || isMobile)
        CreateAssignmentCard(onSave: () {
          setState(() {
            isCreating = false;
          });
        }),
      if (!isMobile) calendar,
    ]);
  }

  MyCalendar get calendar => MyCalendar(
      AssignmentCalendarEvents(StateContainer.of(context).organization.id)
          .getAssignments());
}
