import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/assignment_cards/AssignmentCard.dart';

///
/// Assignment.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

@Deprecated("")
class Assignment extends FirestoreDocument {
  static const String dueDatePath = "due_date";
  static const String notePath = "notes";

  late DateTime dateTime;
  late Member assignee;
  String? notes;

  Assignment(id, name, this.dateTime, this.assignee, {this.notes})
      : super(id, name, {
          FirestoreDocument.namePath: name,
          dueDatePath: dateTime,
          notePath: notes,
        });

  Assignment.model(int id, String name) : super(id, name, {});

  /// Used to ONLY create new instances in the Database
  Assignment.create(String name,
      {required this.dateTime, required this.assignee, this.notes})
      : super(-1, name, {
          FirestoreDocument.namePath: name,
          dueDatePath: dateTime,
          notePath: notes,
        });

  // region Static Members
  static Assignment example1 = Assignment(-1, "Set Appointment", DateTime.now(),
      Member.wardExecutiveSecretaryExample,
      notes: "Interview with Sister Bezos");
  static Assignment example2 = Assignment(-1, "Follow up on Sunday School",
      DateTime.now(), Member.counselor2Example,
      notes: " - Get teachers called to serve on the third sunday");
  static Assignment example3 =
      Assignment(-1, "Eat Burgers", DateTime.now(), Member.wardClerkExample);
  static Assignment example4 = Assignment(
      -1, "Read Handbook", DateTime.now(), Member.counselor1Example,
      notes: "Read chapter 14");
  static Assignment example5 = Assignment(
      -1, "Add Receipts", DateTime.now(), Member.assistantWardClerkExample);

  static List<Assignment> assignmentExampleList = [
    example1,
    example2,
    example3,
    example4,
    example5
  ];

  static List<AssignmentCard> assignmentExampleCardList = [
    AssignmentCard(example1),
    AssignmentCard(example2),
    AssignmentCard(example3),
    AssignmentCard(example4),
    AssignmentCard(example5)
  ];
//endregion
}
