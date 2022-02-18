import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/account_not_found_error.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/account/mock_account_repository.dart';

///
/// delete_account_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class DeactivateAccountUseCaseTest with Test {
  static final Account _mockAccount =
      MockAccount(id: MockAccountID().id).account;

  // REPO FUNCTION CALLS
  // - uses Account Repo
  //   - calls remove
  //   - calls find
  static void verifyRepoFunctionCalls() async {
    MockAccountRepository mockRepo =
        MockAccountRepository(account: _mockAccount);
    DeactivateAccountUseCase useCase =
        DefaultDeactivateAccountUseCase(mockRepo);

    await useCase.execute(
        accountID: MockAccountID().id, accessorID: MockAccountID().id);

    expect(mockRepo.activateFlag, false);

    expect(mockRepo.findFlag, true);

    expect(mockRepo.findByEmailFlag, false);

    expect(mockRepo.findByPhoneFlag, false);

    expect(mockRepo.findByUsernameFlag, false);

    expect(mockRepo.findStreamedFlag, false);

    expect(mockRepo.insertFlag, false);

    expect(mockRepo.loginFlag, false);

    expect(mockRepo.logoutFlag, false);

    expect(mockRepo.removeFlag, true);

    expect(mockRepo.updateFlag, false);
  }

  // VERIFY PERMISSIONS
  // - ensure that the user is the same person who is trying to deactivate the
  //    account. In some ways this may require the authenticate use case?
  static void verifyPermissions() async {
    // Currently the ID is called into the function twice. This should shift to
    //    Authenticating the user with the Authentication UseCase
  }

  // VERIFY RESULTS
  // - if successful true is returned
  // - if failure errors are thrown
  //   - Account Not Found when accessor is not found
  //   - Account Not found when account to deactivate does not exist
  //   - Permission denied when the account of the accessor and the account for
  //      deactivation are different accounts
  static void verifyResults() async {
    // Expected Result
    MockAccountRepository mockRepo =
        MockAccountRepository(account: _mockAccount);
    DeactivateAccountUseCase useCase =
        DefaultDeactivateAccountUseCase(mockRepo);

    bool results = await useCase.execute(
        accountID: MockAccountID().id, accessorID: MockAccountID().id);
    expect(results, true);

    // Accessor is not found
    try {
      MockAccountRepository mockRepo =
          MockAccountRepository(account: _mockAccount);
      DeactivateAccountUseCase useCase =
          DefaultDeactivateAccountUseCase(mockRepo);

      await useCase.execute(
          accountID: MockAccountID().id,
          accessorID: MockAccountID(id: "Account Does Not Exists").id);

      Test.fallthrough(notes: "Failed to notify when an accessor is not found");
    } catch (error) {
      expect(error.toString(), AccountNotFoundError().toString());
    }

    // Account to deactivate is not found
    try {
      MockAccountRepository mockRepo =
          MockAccountRepository(account: _mockAccount);
      DeactivateAccountUseCase useCase =
          DefaultDeactivateAccountUseCase(mockRepo);

      await useCase.execute(
          accountID: MockAccountID(id: "Account Does Not Exists").id,
          accessorID: MockAccountID().id);

      Test.fallthrough(
          notes: "Failed to notify when an account to deactivate is not found");
    } catch (error) {
      expect(error.toString(), AccountNotFoundError().toString());
    }

    // TODO Accessor and Account to deactivate are not the same account
    /// With the current Mock Repo this is not possible to test at this time
    try {
      // MockAccountRepository mockRepo = MockAccountRepository();
      // DeactivateAccountUseCase useCase =
      //     DefaultDeactivateAccountUseCase(mockRepo);
      //
      // await useCase.execute(
      //     accountID: MockAccountID().id, accessorID: MockAccountID().id);
      //
      // Test.fallthrough(
      //     notes: "Failed to notify accessor and account are not the same");
    } catch (error) {
      // expect(
      //     error.toString(),
      //     PermissionDeniedError(
      //             reason: "Attempting to deactivate an others account")
      //         .toString());
    }
  }
}

runDeactivateAccountUseCaseTests() {
  group("Deactivate Account", () {
    test("verify function repo calls",
        DeactivateAccountUseCaseTest.verifyRepoFunctionCalls);
    test("verify permissions", DeactivateAccountUseCaseTest.verifyPermissions);
    test("verify results", DeactivateAccountUseCaseTest.verifyResults);
  });
}
