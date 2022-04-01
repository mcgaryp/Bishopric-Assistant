import 'package:bishop_assistant_web_test_app/firebase/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

///
/// assignment_incomplete.dart
/// bishopric-assistant
///
/// Created by Po on 2/8/22
/// Copyright 2022 Po. All rights reserved.
///

class AssignmentIncomplete extends StatelessWidget {
  final bool _isArchived;
  final TextStyle _style;
  final MyButtonStyle _buttonStyle;
  final AssignmentID assignmentID;

  const AssignmentIncomplete({Key? key, required this.assignmentID})
      : _isArchived = false,
        _style = body,
        _buttonStyle = MyButtonStyle.text,
        super(key: key);

  const AssignmentIncomplete.isArchived({Key? key, required this.assignmentID})
      : _isArchived = true,
        _style = body,
        _buttonStyle = MyButtonStyle.text,
        super(key: key);

  const AssignmentIncomplete.isLight({Key? key, required this.assignmentID})
      : _isArchived = false,
        _style = bodyLight,
        _buttonStyle = MyButtonStyle.lightText,
        super(key: key);

  const AssignmentIncomplete.isArchivedLight(
      {Key? key, required this.assignmentID})
      : _isArchived = true,
        _style = bodyLight,
        _buttonStyle = MyButtonStyle.lightText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _isArchived
        ? Text(sIncomplete, style: _style)
        : MyButton(
            isExpanded: false,
            style: _buttonStyle,
            label: sMarkComplete,
            onPressed: () async {
              try {
                MarkAssignmentCompleteUseCase useCase =
                DefaultMarkAssignmentCompleteUseCase(
                    FirestoreMemberRepository(),
                    FirestoreAssignmentRepository());
                MemberID memberID = StateContainer
                    .of(context)
                    .member
                    .id;
                await useCase.execute(
                    memberID: memberID, assignmentID: assignmentID);
              } catch(e) {
                MyToast.toastError(e);
                if(kDebugMode) print(e);
              }
            });
  }
}
