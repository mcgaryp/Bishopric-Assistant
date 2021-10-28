import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// change_password_use_case.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

/// [ChangePasswordUseCase] interface to define how to change passwords
mixin ChangePasswordUseCase {
  /// [execute] changes the password given a valid [accountID] and [password]
  @required
  Future<Result> execute(
      {required AccountID accountID, required String password});
}

/// [DefaultChangePasswordUseCase] describes the default change password use
///   case
///   TODO: Hash object here? Or in Credentials.
class DefaultChangePasswordUseCase implements ChangePasswordUseCase {
  /// [_accountRepository] private variable with access to repository
  AccountRepository _accountRepository;

  /// [_entity] of attempting to change
  final String _entity = "Account";

  DefaultChangePasswordUseCase(this._accountRepository);

  @override
  Future<Result> execute(
      {required AccountID accountID, required String password}) async {
    Account? account = await _accountRepository.find(accountID);

    if (account == null) return Result.error(AccountNotFoundError());

    Credentials credentials =
        Credentials(password: password, username: account.credentials.username);

    Account updatedAccount = Account.newPassword(account, credentials);

    if (await _accountRepository.update(updatedAccount))
      return Result.value(true);

    return Result.error(FailedToSaveError(forEntity: _entity));
  }
}