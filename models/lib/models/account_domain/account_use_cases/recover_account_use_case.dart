import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';
import 'package:models/shared/repository.dart';

///
/// recover_account_use_case.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

/// [RecoverAccountUseCase] interface describes what is required to recover an
///   account
mixin RecoverAccountUseCase {
  /// [execute] recovers an account given [usernameOrPhone] and
  ///   [secondaryAuthentication] is successful
  @required
  Future<Result<Contact>> execute(String string);
}

/// [DefaultRecoverAccountUseCase] to recover an account
class DefaultRecoverAccountUseCase implements RecoverAccountUseCase {
  /// [_accountRepository] private variable with access to repository
  AccountRepository _accountRepository;

  DefaultRecoverAccountUseCase(this._accountRepository);

  @override
  Future<Result<Contact>> execute(String string) async {
    Account? account = await _accountRepository.findByUsername(string);
    if (account == null) account = await _accountRepository.findByPhone(string);
    if (account == null) account = await _accountRepository.findByEmail(string);

    if (account == null) return Result.error(AccountNotFoundError());

    return Result.value(account.contact);
  }
}
