import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:the_assistant/firebase/repositories/repositories.dart';

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
  final bool _isLight;

  const AssignmentComplete.isArchived({Key? key, required this.assignmentID})
      : this._isLight = false,
        super(key: key);

  const AssignmentComplete.isOverDue({Key? key, required this.assignmentID})
      : this._isLight = true,
        super(key: key);

  const AssignmentComplete({Key? key, required this.assignmentID})
      : this._isLight = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButton.icon(
        icon: Icon(
          Icons.check_circle_outline,
          color: _isLight ? light : darkText,
        ),
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
