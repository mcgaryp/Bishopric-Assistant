import 'package:bishop_assistant_web_test_app/firebase/repositories/firebase_assignment_repo.dart';
import 'package:bishop_assistant_web_test_app/pages/assignment/assignment_detail_view.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/assignment.dart';

///
/// archive_assignment_list_view.dart
/// bishopric-assistant
///
/// Created by Po on 2/5/22
/// Copyright 2022 Po. All rights reserved.
///

class ArchiveAssignmentListView extends StatelessWidget {
  const ArchiveAssignmentListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FindAllArchivedAssignmentsUseCase useCase =
        DefaultFindAllArchivedAssignmentsUseCase(FirebaseAssignmentRepo());

    return StreamBuilder<List<Stream<Assignment>>>(
        stream: useCase.execute(StateContainer.of(context).organization.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Stream<Assignment>> assignments = snapshot.data!;
            return Column(
                children: assignments
                    .map((Stream<Assignment> assignmentStream) =>
                        AssignmentDetailView(assignmentStream))
                    .toList());
          }
          return SpinKitThreeBounce(color: dark, size: 25);
        });
  }
}
