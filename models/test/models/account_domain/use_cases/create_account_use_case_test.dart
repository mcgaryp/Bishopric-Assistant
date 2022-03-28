import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/account/mock_account_repository.dart';
import '../../../mocks/account/mock_contact.dart';
import '../../../mocks/account/mock_credentials.dart';
import '../../../mocks/account/mock_name.dart';

///
/// create_account_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class CreateAccountUseCaseTest with Test {
  static final Account _mockAccount = MockAccount(
          id: MockAccountID().id,
          credentials: MockCredentials(username: "New User Name").credentials)
      .account;

  // REPO FUNCTION CALLS
  // - Uses Account Repo
  //   - calls findByUsername
  //   - calls insert
  //   - TODO: calls login, this is a feature not yet included but will be later
  static void verifyRepoFunctionCalls() async {
    MockAccountRepository mockRepo =
        MockAccountRepository(account: _mockAccount);
    CreateAccountUseCase useCase = DefaultCreateAccountUseCase(mockRepo);

    await useCase.execute(
      name: MockName().name,
      contact: MockContact().contact,
      credentials: MockCredentials().credentials,
    );

    expect(mockRepo.activateFlag, false);

    expect(mockRepo.findFlag, false);

    expect(mockRepo.findByEmailFlag, false);

    expect(mockRepo.findByPhoneFlag, false);

    expect(mockRepo.findByUsernameFlag, true);

    expect(mockRepo.findStreamedFlag, false);

    expect(mockRepo.insertFlag, true);

    expect(mockRepo.loginFlag, false);

    expect(mockRepo.logoutFlag, false);

    expect(mockRepo.deactivateFlag, false);

    expect(mockRepo.updateFlag, false);
  }

// VERIFY PERMISSIONS
// - TODO: checks to make sure that email is valid. This prevents DB spamming
  static void verifyPermissionToCreate() async {
// This is not yet verified nor can it be because this portion of the
//    account has not been created yet
  }

// VERIFY RESULTS
// - Expected errors are thrown
//   - failed to save account
//   - account already exists
// - returns the account
  static void verifyResults() async {
// Expected out come of success
    MockAccountRepository mockRepo =
        MockAccountRepository(account: _mockAccount);
    CreateAccountUseCase useCase = DefaultCreateAccountUseCase(mockRepo);

    bool result = await useCase.execute(
        name: MockName().name,
        credentials: MockCredentials().credentials,
        contact: MockContact().contact);
    expect(result, true);

    // Failed to Save account Error
    try {
      MockAccountRepository mockRepo =
          MockAccountRepository(account: _mockAccount, shouldFail: true);
      CreateAccountUseCase useCase = DefaultCreateAccountUseCase(mockRepo);

      await useCase.execute(
          name: MockName().name,
          credentials: MockCredentials().credentials,
          contact: MockContact().contact);

      Test.fallthrough(
          notes: "Account does not notify user with a failure to "
              "save the account");
    } catch (error) {
      expect(error.toString(), FailedToSaveError(reason: "Account").toString());
    }

    // Account Already Exists Error
    try {
      MockAccountRepository mockRepo = MockAccountRepository();
      CreateAccountUseCase useCase = DefaultCreateAccountUseCase(mockRepo);

      await useCase.execute(
          name: MockName().name,
          credentials: MockCredentials().credentials,
          contact: MockContact().contact);

      Test.fallthrough(
          notes: "Account fails to notify when the account already exists");
    } catch (error) {
      expect(error.toString(), AccountAlreadyExistsError().toString());
    }
  }
}

runCreateAccountUseCaseTests() {
  group("Create Account Use Case", () {
    test("Verify function repo calls",
        CreateAccountUseCaseTest.verifyRepoFunctionCalls);

    test("Verify Permissions",
        CreateAccountUseCaseTest.verifyPermissionToCreate);
    test("Verify results", CreateAccountUseCaseTest.verifyResults);
  });
}
