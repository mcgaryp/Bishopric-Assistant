import 'package:async/async.dart';

export 'package:async/async.dart';
export 'package:async/src/result/result.dart';

///
/// repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

/// [Repository] is a class that interfaces with a database of some kind
/// Type [Entity] must be some form of Entity
/// Type [UUID] must be some form of UUID
/// Type [AlternativeUUID] must be some form of UUID that is not equivalent to [UUID]
abstract class Repository<Entity, UUID, AlternativeUUID> {
  /// [find] an [Entity] in the database
  ///
  /// Returns an [Entity] Optional
  /// @required
  Future<Entity?> find(UUID i);

  /// [findAll] M
  ///
  ///
  /// Returns a [List<Entity>] Optionals
  Stream<List<Entity>> findAll(AlternativeUUID o);

  /// [insert] M
  ///
  /// This class inserts a new M into a database
  /// Returns a [ValueResult] or an [ErrorResult] on a failure
  Future<Entity?> insert(Entity m);

  /// [remove] M
  ///
  /// Returns a [ValueResult] or an [ErrorResult]
  Future<bool> remove(UUID i);

  /// [update] M
  ///
  /// Returns a [ValueResult] or an [ErrorResult]
  Future<bool> update(Entity m);
}

// TODO: Turn into Exceptions?
enum RequestType {
  continue100,
  ok200,
  badRequest400,
  unauthorized401,
  paymentRequired402,
  forbidden403,
  notFound404,
  methodNotAllowed405,
  notAcceptable406,
  requestTimeout408,
  conflict409,
  gone410,
  loginTimeout440,
  noResponse444,
  notImplemented501
}
