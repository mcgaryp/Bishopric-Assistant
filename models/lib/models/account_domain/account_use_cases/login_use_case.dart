import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// login_account.dart
///
///
/// Created by Porter McGary on 11/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin LoginUseCase {
  @required
  Future<Result<bool>> execute(Account account);
}

class DefaultLoginUseCase implements LoginUseCase {
  final AccountRepository _repository;

  DefaultLoginUseCase(this._repository);

  @override
  Future<Result<bool>> execute(Account account) async {
    bool didLogin = await _repository.login();
    if (didLogin) {
      bool didCache = await _repository.cache(account);
      if (didCache) return Result.value(true);
      return Result.error(FailedToSaveError(forEntity: "Account Caching"));
    }
    return Result.error(FailedToLoginError());
  }
}
