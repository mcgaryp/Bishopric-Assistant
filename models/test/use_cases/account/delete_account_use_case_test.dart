import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/models/account_domain/account_use_cases.dart';
import 'package:models/shared/exceptions.dart';

import '../../mocks/account/mock_account_repository.dart';

///
/// delete_account_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class DeleteAccountUseCaseTest {
  static void shouldReturnValidResultWhenGivenValidAccountID() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    DefaultDeleteAccountUseCase deleteAccount =
        DefaultDeleteAccountUseCase(accountRepository);
    AccountID accountID = accountRepository.accounts.first.id;
    Result result = await deleteAccount.execute(accountID, accountID);
    if (result.isError) {
      expect(result.isError, true);
      expect(result.isValue, false);
      expect(result.asValue, null);
      expect(result.asError!.error.toString(),
          FailedToRemoveError(forEntity: "Account").toString());
    } else if (result.isValue) {
      expect(result.isValue, true);
      expect(result.isError, false);
      expect(result.asError, null);
      expect(result.asValue!.value, true);
    }
  }

  static void
      shouldReturnAccountNotFoundErrorWhenGivenInvalidAccountID() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    DefaultDeleteAccountUseCase deleteAccount =
        DefaultDeleteAccountUseCase(accountRepository);
    AccountID accountID = AccountID("Bad ID");
    Result result = await deleteAccount.execute(accountID, accountID);
    expect(result.isError, true);
    expect(result.isValue, false);
    expect(result.asValue, null);
    expect(result.asError!.error.toString(), AccountNotFoundError().toString());
  }
}

runDeleteAccountUseCaseTests() {
  group("Delete Account", () {
    test(
        "should return valid result when given valid account ID",
        DeleteAccountUseCaseTest
            .shouldReturnValidResultWhenGivenValidAccountID);
    test(
        "should return account not found when invalid id given",
        DeleteAccountUseCaseTest
            .shouldReturnAccountNotFoundErrorWhenGivenInvalidAccountID);
  });
}
