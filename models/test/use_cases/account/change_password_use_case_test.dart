import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/models/account_domain/account_use_cases.dart';
import 'package:models/shared/foundation.dart';
import 'package:models/shared/repository.dart';

import '../../mocks/account/mock_account_repository.dart';

///
/// change_password_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class ChangePasswordUseCaseTest {
  static void
      shouldReturnValidResultWhenValidAccountIDAndPasswordGiven() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    ChangePasswordUseCase changePasswordUseCase =
        DefaultChangePasswordUseCase(accountRepository);
    Account account = accountRepository.accounts.first;
    Result result = await changePasswordUseCase.execute(
        accountID: account.id, password: "newPassword");
    if (result.isValue) {
      expect(result.isValue, true);
      expect(result.isError, false);
      expect(result.asError, null);
      expect(result.asValue!.value, true);
      // TODO:
    } else if (result.isError) {
      expect(result.isValue, false);
      expect(result.isError, true);
      expect(result.asError!.error.toString(),
          FailedToSaveError(forEntity: "Account").toString());
      expect(result.asValue, null);
    }
  }

  static void
      shouldReturnAccountNotFoundErrorWhenInvalidAccountIDGiven() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    ChangePasswordUseCase changePasswordUseCase =
        DefaultChangePasswordUseCase(accountRepository);
    AccountID id = AccountID("Bad ID");
    Result result = await changePasswordUseCase.execute(
        accountID: id, password: "newPassword");
    expect(result.isValue, false);
    expect(result.isError, true);
    expect(result.asValue, null);
    expect(result.asError!.error.toString(), AccountNotFoundError().toString());
  }
}

runChangePasswordUseCaseTests() {
  group("Change Password Use Case", () {
    test(
        "should return valid result when account id and password are given",
        ChangePasswordUseCaseTest
            .shouldReturnValidResultWhenValidAccountIDAndPasswordGiven);
    test(
        "should return Account not Found Error when bad account ID given",
        ChangePasswordUseCaseTest
            .shouldReturnAccountNotFoundErrorWhenInvalidAccountIDGiven);
  });
}
