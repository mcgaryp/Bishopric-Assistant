import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// delete_account_use_case.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 9/29/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [DeleteAccountUseCase] interface describes how an account is deleted from a
///   system
mixin DeleteAccountUseCase {
  /// [execute] removes an account from a system given a valid [accountID]
  @required
  Future<bool> execute(AccountID accessorID, AccountID accountID);
}

/// [DeleteAccountUseCase] to remove an account from a system
class DefaultDeleteAccountUseCase implements DeleteAccountUseCase {
  /// [_accountRepository] private variable with access to repository
  AccountRepository _accountRepository;

  DefaultDeleteAccountUseCase(this._accountRepository);

  @override
  Future<bool> execute(AccountID accessorID, AccountID accountID) async {
    Account? accessor = await _accountRepository.find(accessorID);
    if (accessor == null) throw AccountNotFoundError();
    Account? account = await _accountRepository.find(accountID);
    if (account == null) throw AccountNotFoundError();
    if (accessor != account)
      throw PermissionDeniedError(
          reason: "May not remove Account that is not yours");
    return await _accountRepository.remove(account.id);
  }
}
