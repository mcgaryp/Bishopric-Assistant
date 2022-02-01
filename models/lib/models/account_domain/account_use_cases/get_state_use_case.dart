import 'package:models/models/account.dart';

///
/// get_state_use_case.dart
/// bishopric-assistant
///
/// Created by Po on 1/30/22
/// Copyright 2022 Po. All rights reserved.
///

mixin GetStateUseCase {
  Future<UserState> execute();
}

class DefaultGetStateUseCase implements GetStateUseCase {
  final StateRepository repository;

  DefaultGetStateUseCase(this.repository);

  @override
  Future<UserState> execute() {
    return repository.find();
  }
}
