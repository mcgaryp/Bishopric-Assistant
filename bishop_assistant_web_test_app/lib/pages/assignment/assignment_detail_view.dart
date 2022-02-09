import 'dart:async';

import 'package:bishop_assistant_web_test_app/widgets/cards/assignment_card/over_due_assignment_card.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

///
/// assignment_detail_view.dart
/// bishopric-assistant
///
/// Created by Po on 2/5/22
/// Copyright 2022 Po. All rights reserved.
///

class AssignmentDetailView extends StatefulWidget {
  final Stream<Assignment> assignmentStream;

  const AssignmentDetailView(this.assignmentStream, {Key? key})
      : super(key: key);

  @override
  State<AssignmentDetailView> createState() => _AssignmentDetailViewState();
}

class _AssignmentDetailViewState extends State<AssignmentDetailView> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    Member currentUser = StateContainer.of(context).member;
    return StreamBuilder<Assignment>(
      stream: widget.assignmentStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Assignment assignment = snapshot.data!;
          if (assignment.canView(
              permissions: currentUser.role.permissions,
              memberID: currentUser.id)) {
            if (assignment.isArchived)
              return ArchivedAssignmentCard(assignment);
            if (assignment.isOverDue)
              return _isEditing
                  ? EditAssignmentCard(assignment, _save)
                  : OverDueAssignmentCard(assignment, _edit);
            return _isEditing
                ? EditAssignmentCard(assignment, _save)
                : DefaultAssignmentCard(assignment, _edit);
          }
          return Container();
        }
        if (snapshot.hasError) return Error404(msg: snapshot.error);
        return Container();
      },
    );
  }

  void _edit() => setState(() => _isEditing = true);

  void _save() => setState(() => _isEditing = false);
}
