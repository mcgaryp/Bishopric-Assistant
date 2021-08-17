import 'package:bishop_assistant_web_test_app/database/DatabaseModel.dart';
import 'package:bishop_assistant_web_test_app/database/models/EventType.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/event_cards/EventCard.dart';

///
/// Event.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

abstract class Event extends DatabaseModel {
  late EventType eventType;
  late DateTime dateTime;
  String? location;
  String? notes;
  String? agenda;
  String? interviewee;
  List<Member>? assignees;

  Event(id, name, this.dateTime, this.eventType,
      {this.location,
      this.notes,
      this.assignees,
      this.agenda,
      this.interviewee})
      : super(id, name);
}

class Meeting extends Event {
  static List<EventCard> meetingExampleCardList = [
    EventCard(example1),
    EventCard(example2),
    EventCard(example3)
  ];

  Meeting(
    int id,
    String name,
    DateTime dateTime,
    String agenda,
    List<Member> assignees, {
    String? place,
    String? notes,
  }) : super(id, name, dateTime, EventType.meeting,
            location: place,
            notes: notes,
            agenda: agenda,
            assignees: assignees);

  static Meeting example1 = Meeting(-1, "Ward Counsel", DateTime.now(),
      _exampleAgenda, [Member.bishopExample, Member.counselor1Example],
      place: "Bishops office", notes: _exampleNote);

  static Meeting example2 =
      Meeting(-1, "Bishopric", DateTime.now(), "TBD", Member.exampleMemberList);
  static Meeting example3 = Meeting(-1, "Sunday School Presidency",
      DateTime.now(), _exampleAgenda, [Member.counselor1Example],
      notes: "Focus on the teaching of new teachers");

  static List<Meeting> meetingExampleList = [example1, example2, example3];

  static String _exampleNote =
      "It is a long established fact that a reader will be distracted by"
      " the readable content of a page when looking at its layout. "
      "The point of using Lorem Ipsum is that it has a more-or-less "
      "normal distribution of letters, as opposed to using 'Content "
      "here, content here', making it look like readable English. "
      "Many desktop publishing packages and web page editors now "
      "use Lorem Ipsum as their default model text, and a search "
      "for 'lorem ipsum' will uncover many web sites still in their "
      "infancy. Various versions have evolved over the years, "
      "sometimes by accident, sometimes on purpose (injected humour "
      "and the like).";

  static String _exampleAgenda = " - paragraphs\n - words\n - bytes\n - lists";
}

class Interview extends Event {
  Interview(int id, String name, DateTime dateTime, String interviewee,
      Member assignee, {String? notes})
      : super(id, name, dateTime, EventType.interview,
            notes: notes, assignees: [assignee], interviewee: interviewee);

  static Interview example1 = Interview(-1, "Temple Interview", DateTime.now(),
      "John John", Member.counselor1Example);

  static Interview example2 = Interview(-1, "Temple Interview", DateTime.now(),
      "Member of the Ward", Member.counselor1Example);

  static List<Interview> interviewExampleList = [example1, example2];
  static List<EventCard> interviewExampleCardList = [
    EventCard(example1),
    EventCard(example2)
  ];
}
