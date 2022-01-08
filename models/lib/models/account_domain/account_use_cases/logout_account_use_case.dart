import 'package:models/models/account.dart';

///
/// logout_account_use_case.dart
/// bishopric-assistant
///
/// Created by Po on 12/30/21
/// Copyright 2021 Po. All rights reserved.
///

mixin LogoutAccountUseCase {
  @required
  Future<bool> execute();
}

class DefaultLogoutAccountUseCase implements LogoutAccountUseCase {
  final AccountRepository _accountRepository;

  DefaultLogoutAccountUseCase(this._accountRepository);

  @override
  Future<bool> execute() {
    return _accountRepository.logout();
  }
}
