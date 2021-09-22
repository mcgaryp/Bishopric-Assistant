import 'package:models/models/events/Event.dart';
import 'package:models/shared/repository.dart';

///
/// event_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Comments
abstract class EventRepository extends Repository<Event> {
  /// Finds a all [Event]s using given [memberId].
  ///
  /// [memberId] Id
  /// Returns List of [Event] if found, else 'null'
  List<Event>? findAllForMember(int memberId);

  /// Finds an [Event] using given [eventId].
  ///
  /// [eventId] Id
  /// Returns an [Event] if found, else 'null'
  Event? find(int eventId);

  /// Saves given [Event].
  ///
  /// [event] to save
  void store(Event event);
}

mixin Test {
  final apple = 4;
  void myApple();
}
