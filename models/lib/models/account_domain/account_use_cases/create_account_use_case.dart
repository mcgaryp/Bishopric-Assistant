import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// create_account_use_case.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

/// [CreateAccountUseCase] interface describes the requirements to create an
///   account
mixin CreateAccountUseCase {
  /// [execute] creates an account given a valid [name], [contact], and
  ///   [credentials]
  @required
  Future<Result<Account>> execute(
      {required Name name,
      required Contact contact,
      required Credentials credentials});
}

/// [DefaultCreateAccountUseCase] default way to create an account
class DefaultCreateAccountUseCase implements CreateAccountUseCase {
  /// [_accountRepository] private variable with access to repository
  AccountRepository _accountRepository;

  /// [_entity] of attempting to change
  final String _entity = "Account";

  DefaultCreateAccountUseCase(this._accountRepository);

  @override
  Future<Result<Account>> execute(
      {required Name name,
      required Contact contact,
      required Credentials credentials}) async {
    try {
      if (await _accountRepository.findByUsername(credentials.username) != null)
        return Result.error(AccountAlreadyExistsError());

      AccountID? id = await _accountRepository.generateNextId();

      if (id == null)
        return Result.error(UnableToGenerateIdError(forEntity: _entity));

      Account account = Account(
          id: id, name: name, contact: contact, credentials: credentials);

      if (await _accountRepository.insert(account))
        return Result.value(account);

      return Result.error(FailedToSaveError(forEntity: _entity));
    } catch (error) {
      throw error;
    }
  }
}
