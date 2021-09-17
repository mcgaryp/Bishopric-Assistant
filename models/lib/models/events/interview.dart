import 'package:models/models/events/Event.dart';

///
/// interview.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

class interview extends Event {
  interview(
      String name, String location, DateTime dateTime, List<Member> attendees)
      : super(name, location, dateTime, attendees);
}
