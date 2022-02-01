import 'package:models/models/account.dart';

///
/// save_state_use_case.dart
/// bishopric-assistant
///
/// Created by Po on 1/30/22
/// Copyright 2022 Po. All rights reserved.
///

mixin SaveStateUseCase {
  Future<bool> execute(UserState state);
}

class DefaultSaveStateUseCase implements SaveStateUseCase {
  final StateRepository repository;
  DefaultSaveStateUseCase(this.repository);

  @override
  Future<bool> execute(UserState state) {
    return repository.insert(state);
  }
}
