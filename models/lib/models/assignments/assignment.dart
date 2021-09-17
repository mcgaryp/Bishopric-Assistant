import 'package:models/models/events/event.dart';
import 'package:models/shared/entity.dart';

///
/// assignment.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

class Assignment extends Head implements Entity<Assignment> {
  final String _assignee;

  Assignment(String name, DateTime dateTime, String? notes, this._assignee)
      : super(name, dateTime, notes);

  @override
  bool sameIdentityAs(Assignment other) {
    // TODO: implement sameIdentityAs
    throw UnimplementedError();
  }
}
