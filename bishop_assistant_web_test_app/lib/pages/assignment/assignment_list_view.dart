import 'package:bishop_assistant_web_test_app/firebase/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/pages/assignment/assignment_detail_view.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/assignment.dart';

///
/// assignment_list_view.dart
/// bishopric-assistant
///
/// Created by Po on 2/5/22
/// Copyright 2022 Po. All rights reserved.
///

class AssignmentListView extends StatelessWidget {
  const AssignmentListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Stream<Assignment>>>(
        stream: FirestoreAssignmentRepository()
            .findAllStreamed(StateContainer.of(context).organization.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Stream<Assignment>> assignments = snapshot.data!;
            return Column(
                children: assignments
                    .map<AssignmentDetailView>(
                        (Stream<Assignment> assignmentStream) =>
                            AssignmentDetailView(assignmentStream))
                    .toList());
          }
          if (snapshot.hasError) Error404(msg: snapshot.error);
          return SpinKitThreeBounce(color: dark, size: 25);
        });
  }
}
