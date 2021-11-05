import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// logout_use_case.dart
///
///
/// Created by Porter McGary on 11/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin LogoutUseCase {
  @required
  Future<Result<bool>> execute();
}

class DefaultLogoutUseCase implements LogoutUseCase {
  final AccountRepository _repository;

  DefaultLogoutUseCase(this._repository);

  @override
  Future<Result<bool>> execute() async {
    bool didLogout = await _repository.logout();
    if (didLogout) return Result.value(didLogout);
    return Result.error(FailedToLogoutError());
  }
}
