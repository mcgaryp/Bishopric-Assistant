import 'package:models/models/account.dart';

///
/// state_repository.dart
/// bishopric-assistant
///
/// Created by Po on 1/30/22
/// Copyright 2022 Po. All rights reserved.
///

mixin StateRepository {
  Future<bool> insert(UserState state);
  Future<bool> update(UserState state);
  Future<UserState> find();
  Future<bool> remove();
}
