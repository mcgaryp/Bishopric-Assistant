import 'package:models/models/assignments/assignment.dart';
import 'package:models/shared/repository.dart';

///
/// assignment_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

abstract class AssignmentRepository extends Repository<Assignment> {
  /// Finds a all [Assignment]s using given [memberId].
  ///
  /// [memberId] Id
  /// Returns List of [Event] if found, else 'null'
  List<Assignment>? findAllForMember(int memberId);

  /// Finds an [Event] using given [eventId].
  ///
  /// [eventId] Id
  /// Returns an [Event] if found, else 'null'
  Assignment? find(int eventId);

  /// Saves given [Event].
  ///
  /// [event] to save
  void store(Assignment event);
}
