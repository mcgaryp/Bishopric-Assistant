import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// reactivate_account_use_case.dart
///
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin ReactivateAccountUseCase {
  @required
  Future<bool> execute(AccountID id);
}

class DefaultReactivateAccountUseCase implements ReactivateAccountUseCase {
  final AccountRepository _accountRepository;

  DefaultReactivateAccountUseCase(this._accountRepository);

  @override
  Future<bool> execute(AccountID id) async {
    return await _accountRepository.activate(id);
  }
}
