import 'package:models/shared/entity.dart';

///
/// event.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

class Member {}

/// TODO: Notes
abstract class Event extends Head implements Entity<Event> {
  final int id;
  final String _location;
  final List<Member> _attendees;

  Event(
      this.id, String name, DateTime dateTime, this._location, this._attendees,
      {String? notes})
      : super(name, dateTime, notes);

  @override
  bool sameIdentityAs(Event other) {
    return this.id == other.id;
  }
}

/// TODO: Rename this class
abstract class Head {
  final String _name;
  final DateTime _dateTime;
  final String? _notes;

  Head(this._name, this._dateTime, this._notes);
}
