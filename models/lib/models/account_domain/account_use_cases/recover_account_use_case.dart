import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

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
  ///   [recoveryStr] can be a username, phone, or email
  @required
  Future<Contact> execute(String recoveryStr);
}

/// [DefaultRecoverAccountUseCase] to recover an account
class DefaultRecoverAccountUseCase implements RecoverAccountUseCase {
  /// [_accountRepository] private variable with access to repository
  AccountRepository _accountRepository;

  DefaultRecoverAccountUseCase(this._accountRepository);

  @override
  Future<Contact> execute(String recoveryStr) async {
    Account? account = await _accountRepository.findByUsername(recoveryStr);
    if (account == null)
      account = await _accountRepository.findByPhone(recoveryStr);
    if (account == null)
      account = await _accountRepository.findByEmail(recoveryStr);

    if (account == null) throw AccountNotFoundError();

    return account.contact;
  }
}
