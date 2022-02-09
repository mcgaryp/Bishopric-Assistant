import 'package:bishop_assistant_web_test_app/pages/assignment/assignment_list_view.dart';
import 'package:bishop_assistant_web_test_app/pages/assignment/create_assignment_view.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';

///
/// assignments_view.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/7/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class AssignmentsView extends StatelessWidget {
  const AssignmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 700;

    Widget list = ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: padding8),
          child: Text(sAssignments, style: title),
        ),
        AssignmentListView(),
      ],
    );

    if (isMobile) return list;

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Flexible(child: list),
      Flexible(
          child: Padding(
        padding: const EdgeInsets.only(left: padding8),
        child: CreateAssignmentView(),
      ))
    ]);
  }
}
