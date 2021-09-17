///
/// repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

abstract class Repository<T> {
  /// Finds a all [T]s using given [memberId].
  ///
  /// [memberId] Id
  /// Returns List of [T] if found, else 'null'
  List<T>? findAllForMember(int memberId);

  /// Finds [T] using given [id].
  ///
  /// [id] Id
  /// Returns an [T] if found, else 'null'
  T? find(int id);

  /// Saves given [T].
  ///
  /// [t] to save
  void store(T t);
}
