import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// change_contact_use_case.dart
///
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

/// [ChangeContactUseCase] interface defines the subclasses to change contact
///   information
mixin ChangeContactUseCase {
  /// [execute] changes the contact information given the [accountID] and
  ///   [contact] are valid
  @required
  Future<Result> execute(
      {required AccountID accountID, required Contact contact});
}

/// [DefaultChangeContactUseCase] case to change the contact information
class DefaultChangeContactUseCase implements ChangeContactUseCase {
  /// [_accountRepository] private variable with access to repository
  AccountRepository _accountRepository;

  /// [_entity] of attempting to change
  final String _entity = "Account";

  DefaultChangeContactUseCase(this._accountRepository);

  @override
  Future<Result> execute(
      {required AccountID accountID, required Contact contact}) async {
    Account? account = await _accountRepository.find(accountID);

    if (account == null) return Result.error(AccountNotFoundError());

    Account updatedAccount = Account.newContact(account, contact);

    if (await _accountRepository.update(updatedAccount))
      return Result.value(true);

    return Result.error(FailedToSaveError(forEntity: _entity));
  }
}
