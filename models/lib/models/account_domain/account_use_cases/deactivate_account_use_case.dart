import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// deactivate_account_use_case.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 9/29/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [DeactivateAccountUseCase] interface describes how an account is deleted from a
///   system
mixin DeactivateAccountUseCase {
  /// [execute] removes an account from a system given a valid [accountID]
  @required
  Future<bool> execute(
      {required AccountID accessorID, required AccountID accountID});
}

/// [DeactivateAccountUseCase] to remove an account from a system
class DefaultDeactivateAccountUseCase implements DeactivateAccountUseCase {
  /// [_accountRepository] private variable with access to repository
  AccountRepository _accountRepository;

  DefaultDeactivateAccountUseCase(this._accountRepository);

  @override
  Future<bool> execute(
      {required AccountID accessorID, required AccountID accountID}) async {
    Account? accessor = await _accountRepository.find(accessorID);
    if (accessor == null) throw AccountNotFoundError();
    Account? account = await _accountRepository.find(accountID);
    if (account == null) throw AccountNotFoundError();
    if (accessorID != accountID)
      throw PermissionDeniedError(
          reason: "Attempting to deactivate an others account");
    return await _accountRepository.deactivate(account.id);
  }
}
