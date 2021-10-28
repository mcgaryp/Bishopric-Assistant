import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// authenticate_account_use_case.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

/// [AuthenticateAccountUseCase] interface to define the use case subclasses
mixin AuthenticateAccountUseCase {
  /// [execute] authenticates an account given [credentials] are valid
  @required
  Future<Result<Account>> execute(Credentials credentials);
}

/// [DefaultAuthenticateAccountUseCase] is the standard use case to authenticate
///   and account
class DefaultAuthenticateAccountUseCase implements AuthenticateAccountUseCase {
  /// [_accountRepository] private variable with access to repository
  AccountRepository _accountRepository;

  /// [_reason] to deny permission
  final String _reason = "Incorrect Username or Password";

  DefaultAuthenticateAccountUseCase(this._accountRepository);

  @override
  Future<Result<Account>> execute(Credentials credentials) async {
    Account? accountFromBeyond =
        await _accountRepository.findByUsername(credentials.username);

    if (accountFromBeyond == null)
      return Result.error(
          PermissionDeniedError(reason: _reason));

    Credentials credentialsFromBeyond = accountFromBeyond.credentials;

    if (credentials == credentialsFromBeyond)
      return Result.value(accountFromBeyond);

    return Result.error(
        PermissionDeniedError(reason: _reason));
  }
}
