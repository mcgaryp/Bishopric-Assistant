import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// is_logged_in_use_case.dart
///
///
/// Created by Porter McGary on 11/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin IsLoggedInUseCase {
  @required
  Future<Result<Account>> execute();
}

class DefaultIsLoggedInUseCase implements IsLoggedInUseCase {
  final AccountRepository _repository;

  DefaultIsLoggedInUseCase(this._repository);

  @override
  Future<Result<Account>> execute() async {
    LoginStatus isLoggedIn = await _repository.getLoginStatus();
    if (isLoggedIn != LoginStatus.loggedIn)
      return Result.error(FailedToLoginError());
    Account? account = await _repository.getCache();
    return Result.value(account);
  }
}
