import 'package:the_assistant/firebase/repositories/repositories.dart';
import 'package:the_assistant/pages/assignment/assignment_detail_view.dart';
import 'package:the_assistant/widgets/widgets.dart';
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
    return StreamBuilder<List<Stream<Assignment>>>(
        stream: FirestoreAssignmentRepository()
            .findAllStreamed(StateContainer.of(context).organization.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Stream<Assignment>> assignments = snapshot.data!;
            return Column(
                children: assignments
                    .map((Stream<Assignment> assignmentStream) =>
                        AssignmentDetailView(assignmentStream, onlyArchived: true))
                    .toList());
          }
          return SpinKitThreeBounce(color: dark, size: 25);
        });
  }
}
