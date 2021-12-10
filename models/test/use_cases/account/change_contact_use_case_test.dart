import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/models/account_domain/account_use_cases.dart';
import 'package:models/shared/test.dart';

import '../../mocks/account/mock_account_repository.dart';

///
/// change_contact_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class ChangeContactUseCaseTest with Test {
  static void shouldReturnTrueWhenValidContactAndSuccessfulUpdate() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    DefaultChangeContactUseCase changeContact =
        DefaultChangeContactUseCase(accountRepository);
    AccountID accountID = accountRepository.accounts.first.id;
    Contact contact = accountRepository.accounts.last.contact;
    // Result result =
    //     await changeContact.execute(accountID: accountID, contact: contact);
    // if (result.isError)
    //   expect(result.asError?.error.toString(),
    //       FailedToSaveError(forEntity: "Account").toString());
    // if (result.isValue) expect(result.asValue?.value, true);
    throw UnimplementedError();
  }

  static void shouldReturnAccountNotFoundErrorWhenGivenInvalidID() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    DefaultChangeContactUseCase changeContact =
        DefaultChangeContactUseCase(accountRepository);
    AccountID accountID = AccountID("false id");
    Contact contact = accountRepository.accounts.last.contact;
    // Result result =
    //     await changeContact.execute(accountID: accountID, contact: contact);
    // expect(result.isError, true);
    // expect(result.isValue, false);
    // expect(result.asValue, null);
    // expect(result.asError!.error.toString(), AccountNotFoundError().toString());
    throw UnimplementedError();
  }
}

runChangeContactTests() {
  group("Change Contact Tests", () {
    test(
        "should return some kind of result based on the success of the backend",
        ChangeContactUseCaseTest
            .shouldReturnTrueWhenValidContactAndSuccessfulUpdate);
    test(
        "should return account not found error when invalid id given",
        ChangeContactUseCaseTest
            .shouldReturnAccountNotFoundErrorWhenGivenInvalidID);
  });
}
