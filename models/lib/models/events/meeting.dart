import 'package:models/models/events/event.dart';

///
/// meeting.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

class Meeting extends Event {
  Meeting(int id, String name, DateTime dateTime, String location,
      List<Member> attendees)
      : super(id, name, dateTime, location, attendees);
}
