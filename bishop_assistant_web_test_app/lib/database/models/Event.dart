import 'package:bishop_assistant_web_test_app/database/DatabaseModel.dart';
import 'package:bishop_assistant_web_test_app/database/models/EventType.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
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
  Map<String, dynamic> map;

  Event(id, name, this.dateTime, this.eventType,
      {this.location,
      this.notes,
      this.assignees,
      this.agenda,
      this.interviewee,
      required this.map})
      : super(id, name, map);
}

// {
// "name": name,
// EventsDoc.place: location,
// EventsDoc.notes: notes,
// EventsDoc.agenda: agenda,
// EventsDoc.date: dateTime,
// EventsDoc.eventType: eventType.index,
// EventsDoc.interviewee: interviewee,
// // TOD0: Assignee(s)
// }

class Meeting extends Event {
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
            assignees: assignees,
            map: {
              "name": name,
              EventsDoc.date: dateTime,
              EventsDoc.agenda: agenda,
              EventsDoc.place: place,
              EventsDoc.notes: notes,
              EventsDoc.eventType: EventType.meeting.index,
            });

  // region Static Members
  static Meeting example1 = Meeting(-1, "Ward Counsel", DateTime.now(),
      _exampleAgenda, [Member.bishopExample, Member.counselor1Example],
      place: "Bishops office", notes: _exampleNote);

  static Meeting example2 =
      Meeting(-1, "Bishopric", DateTime.now(), "TBD", Member.exampleMemberList);
  static Meeting example3 = Meeting(-1, "Sunday School Presidency",
      DateTime.now(), _exampleAgenda, [Member.counselor1Example],
      notes: "Focus on the teaching of new teachers");

  static List<Meeting> meetingExampleList = [example1, example2, example3];

  static List<EventCard> meetingExampleCardList = [
    EventCard(example1),
    EventCard(example2),
    EventCard(example3)
  ];

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
// endregion
}

class Interview extends Event {
  Interview(int id, String name, DateTime dateTime, String interviewee,
      Member assignee,
      {String? notes})
      : super(id, name, dateTime, EventType.interview,
            notes: notes,
            assignees: [assignee],
            interviewee: interviewee,
            map: {
              "name": name,
              EventsDoc.date: dateTime,
              EventsDoc.notes: notes,
              EventsDoc.interviewee: interviewee,
              EventsDoc.eventType: EventType.interview.index,
            });

  // region Static Members
  static Interview example1 = Interview(-1, "Temple Interview", DateTime.now(),
      "John John", Member.counselor1Example);

  static Interview example2 = Interview(-1, "Temple Interview", DateTime.now(),
      "Member of the Ward", Member.counselor1Example);

  static List<Interview> interviewExampleList = [example1, example2];
  static List<EventCard> interviewExampleCardList = [
    EventCard(example1),
    EventCard(example2)
  ];
// endregion
}

extension ParseEventType on EventType {
  static EventType fromString(String string) {
    switch (string) {
      case "Interview":
        return EventType.interview;
      case "Meeting":
        return EventType.meeting;
      default:
        return EventType.none;
    }
  }
}
