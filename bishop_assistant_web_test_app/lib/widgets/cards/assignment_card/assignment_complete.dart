import 'package:the_assistant/firebase/repositories/repositories.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

import '../../widgets.dart';

///
/// assignment_complete.dart
/// bishopric-assistant
///
/// Created by Po on 2/8/22
/// Copyright 2022 Po. All rights reserved.
///

class AssignmentComplete extends StatelessWidget {
  final AssignmentID assignmentID;

  const AssignmentComplete({Key? key, required this.assignmentID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButton.icon(
        icon: Icon(Icons.check_circle_outline, color: dark),
        onPressed: () async {
          try {
            MarkAssignmentIncompleteUseCase useCase =
                DefaultMarkAssignmentIncompleteUseCase(
                    FirestoreMemberRepository(),
                    FirestoreAssignmentRepository());
            MemberID memberID = StateContainer.of(context).member.id;
            await useCase.execute(
                memberID: memberID, assignmentID: assignmentID);
          } catch (e) {
            MyToast.toastError(e);
            if (kDebugMode) print(e);
          }
        });
  }
}
