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
  Future<Account> execute(
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
  Future<Account> execute(
      {required Name name,
      required Contact contact,
      required Credentials credentials}) async {
    if (await _accountRepository.findByUsername(credentials.username) != null)
      throw AccountAlreadyExistsError();

    Account account =
        Account(name: name, contact: contact, credentials: credentials);

    Account? insertedAccount = await _accountRepository.insert(account);
    if (insertedAccount != null) return insertedAccount;

    throw FailedToSaveError(forEntity: _entity);
  }
}
