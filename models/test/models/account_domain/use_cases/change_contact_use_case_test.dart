import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/account/mock_account_repository.dart';
import '../../../mocks/account/mock_contact.dart';

///
/// change_contact_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class ChangeContactUseCaseTest with Test {
  // REPO FUNCTION CALLS
  // - Account Repo
  //   - calls find
  //   - calls update
  static void verifyRepoFunctionCalls() async {
    MockAccountRepository mockRepo = MockAccountRepository();
    ChangeContactUseCase useCase = DefaultChangeContactUseCase(mockRepo);

    Account account = MockAccount(
            id: MockAccountID().id,
            contact: MockContact(email: "NewFake@email.com").contact)
        .account;
    await useCase.execute(accountID: account.id, contact: account.contact);

    expect(mockRepo.activateFlag, false);
    expect(mockRepo.findFlag, true);
    expect(mockRepo.findByEmailFlag, false);
    expect(mockRepo.findByPhoneFlag, false);
    expect(mockRepo.findByUsernameFlag, false);
    expect(mockRepo.findStreamedFlag, false);
    expect(mockRepo.insertFlag, false);
    expect(mockRepo.loginFlag, false);
    expect(mockRepo.logoutFlag, false);
    expect(mockRepo.deactivateFlag, false);
    expect(mockRepo.updateFlag, true);
  }

  // VERIFY PERMISSIONS
  // - Accessor is the user accessing the account
  static void verifyAccessorIsOwnerOfAccount() async {
    // There is not much of a way to do this and know that the user is not just
    //    passing in the accountID twice. For that reason this issue should be
    //    looked into more before implementing a solid reliable test.
  }

  // VERIFY RESULTS
  // - returns true if successful and error with error displayed if not
  static void verifyResults() async {
    // Expected true outcome
    MockAccountRepository mockRepo = MockAccountRepository();
    ChangeContactUseCase useCase = DefaultChangeContactUseCase(mockRepo);

    Account account = MockAccount(
            id: MockAccountID().id,
            contact: MockContact(email: "NewFake@email.com").contact)
        .account;
    bool results =
        await useCase.execute(accountID: account.id, contact: account.contact);
    expect(results, true);

    // Account not found error
    try {
      await useCase.execute(
          accountID: MockAccountID(id: "Fake ID!!").id,
          contact: MockContact(email: "Email@you.com").contact);
      Test.fallthrough(notes: "Account is not confirmed to exist or not");
    } catch (error) {
      expect(error.toString(), AccountNotFoundError().toString());
    }

    // Account contact is the same as the previous
    try {
      MockAccountRepository mockRepo = MockAccountRepository();
      useCase = DefaultChangeContactUseCase(mockRepo);
      await useCase.execute(
          accountID: MockAccountID().id,
          contact: MockAccount().account.contact);
      Test.fallthrough(
          notes: "Account does not confirm that the contact is the"
              " same");
    } catch (error) {
      expect(
          error.toString(),
          PermissionDeniedError(reason: "No contact information was changed")
              .toString());
    }

    // Account failed to update
    try {
      MockAccountRepository failToUpdateRepo =
          MockAccountRepository(shouldFail: true);
      useCase = DefaultChangeContactUseCase(failToUpdateRepo);
      await useCase.execute(
          accountID: MockAccountID().id,
          contact: MockContact(email: "Email@you.com").contact);
      Test.fallthrough(notes: "Account should have failed to update");
    } catch (error) {
      expect(error.toString(), FailedToSaveError(reason: "Account").toString());
    }
  }
}

runChangeContactTests() {
  group("Change Contact Tests", () {
    test("verifies repository calls",
        ChangeContactUseCaseTest.verifyRepoFunctionCalls);
    test("verifies the proper permissions are given",
        ChangeContactUseCaseTest.verifyAccessorIsOwnerOfAccount);
    test("verify the results", ChangeContactUseCaseTest.verifyResults);
  });
}
