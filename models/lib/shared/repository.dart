import 'package:async/async.dart';

export 'package:async/async.dart';

///
/// repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

abstract class Repository<M, I> {
  /// [find] an M
  ///
  /// Returns an [M]
  /// @required
  Future<M> find(I i);

  /// [findAll] M
  ///
  /// Returns a [List<M>]s
  Future<List<M>> findAll();

  /// [store] M
  ///
  /// Returns a [ValueResult] or an [ErrorResult]
  Future<Result> store(M m);

  /// [remove] M
  ///
  /// Returns a [ValueResult] or an [ErrorResult]
  Future<Result> remove(I i);

  /// [update] M
  ///
  /// Returns a [ValueResult] or an [ErrorResult]
  Future<Result> update(M m);

  /// [generateNextId] for the M
  ///
  /// Returns a [I]
  Future<I> generateNextId();
}
