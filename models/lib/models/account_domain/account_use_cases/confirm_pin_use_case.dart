import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// confirm_pin_use_case.dart
///
///
/// Created by Porter McGary on 10/27/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [ConfirmPinUseCase] Returns a valid account that has been verified by the
/// user with a PIN
mixin ConfirmPinUseCase {
  @required
  Future<AccountID> execute(String username);
}

class DefaultConfirmPinUseCase implements ConfirmPinUseCase {
  final AccountRepository _accountRepository;

  DefaultConfirmPinUseCase(this._accountRepository);

  @override
  Future<AccountID> execute(String username) async {
    Account? account = await _accountRepository.findByUsername(username);

    if (account == null) throw AccountNotFoundError();
    return account.id;
  }
}
