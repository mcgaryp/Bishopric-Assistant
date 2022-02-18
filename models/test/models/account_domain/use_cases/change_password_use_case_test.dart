import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/account/mock_account_repository.dart';
import '../../../mocks/account/mock_credentials.dart';

///
/// change_password_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class ChangePasswordUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  // - Account Repo
  //   - calls find
  //   - calls update
  static void verifyRepoFunctionCalls() async {
    MockAccountRepository mockRepo = MockAccountRepository();
    ChangePasswordUseCase useCase = DefaultChangePasswordUseCase(mockRepo);

    await useCase.execute(
        accountID: MockAccountID().id,
        password:
            MockCredentials(password: "NeWp4sSwOrD").credentials.password);

    expect(mockRepo.activateFlag, false);
    expect(mockRepo.findFlag, true);
    expect(mockRepo.findByEmailFlag, false);
    expect(mockRepo.findByPhoneFlag, false);
    expect(mockRepo.findByUsernameFlag, false);
    expect(mockRepo.findStreamedFlag, false);
    expect(mockRepo.insertFlag, false);
    expect(mockRepo.loginFlag, false);
    expect(mockRepo.logoutFlag, false);
    expect(mockRepo.removeFlag, false);
    expect(mockRepo.updateFlag, true);
  }

  // VERIFY PERMISSIONS
  // - Accessor is the user accessing the account
  static void verifyAccessorIsOwnerOfAccount() async {
    // There is not much of a way to do this and know that the user is not just
    //    passing in the accountID twice. For that reason this issue should be
    //    looked into more before implementing a solid reliable test.
    // TODO: Perhaps giving the old password as a verification in a third parameter would be wise?
  }

  // VERIFY PASSWORD IS HASHED
  // - calls method hashPassword from Account or another class
  static void verifyPasswordHashing() async {
    // There is not yet been developed a way to properly hash the password. This
    //    software assumes that users have already hashed their secret
    //    information before storing it in a repository.
    // TODO: Develop a strategy to hash passwords for security
  }

  // VERIFY RESULTS
  // - returns true if successful and error with error displayed if not
  static void verifyResults() async {
    // Expected result
    MockAccountRepository mockRepo = MockAccountRepository();
    ChangePasswordUseCase useCase = DefaultChangePasswordUseCase(mockRepo);
    final id = MockAccountID().id;
    final newPassword =
        MockCredentials(password: "NeWp4sSoRd").credentials.password;
    bool result = await useCase.execute(accountID: id, password: newPassword);
    expect(result, true);

    // Throws account not found error
    // - A different account ID is given then matches the current password
    try {
      mockRepo = MockAccountRepository(
          account: MockAccount(id: MockAccountID(id: "Different Account ID").id)
              .account);
      useCase = DefaultChangePasswordUseCase(mockRepo);
      await useCase.execute(accountID: id, password: newPassword);

      Test.fallthrough(
          notes:
              "Does not throw account not found when account is nonexistent");
    } catch (error) {
      expect(error.toString(), AccountNotFoundError().toString());
    }

    // Throws invalid password error
    try {
      mockRepo = MockAccountRepository();
      useCase = DefaultChangePasswordUseCase(mockRepo);
      await useCase.execute(
          accountID: id, password: MockCredentials().credentials.password);

      Test.fallthrough(
          notes: "Failed to throw invalid password error when password is "
              "same as the last password");
    } catch (error) {
      expect(
          error.toString(),
          InvalidPasswordError(
                  InvalidPasswordCase.settingPasswordSameAsPrevious,
                  forObject: "Change Password Use Case")
              .toString());
    }

    // Throws failed to save error
    try {
      mockRepo = MockAccountRepository(shouldFail: true);
      useCase = DefaultChangePasswordUseCase(mockRepo);
      await useCase.execute(accountID: id, password: newPassword);

      Test.fallthrough(notes: "Failed to notify when new password not saved");
    } catch (error) {
      expect(error.toString(),
          FailedToSaveError(reason: "Account Password").toString());
    }
  }
}

runChangePasswordUseCaseTests() {
  group("Change Password Use Case", () {
    test("verifies proper repo functions are called",
        ChangePasswordUseCaseTest.verifyRepoFunctionCalls);
    test("verifies user permissions",
        ChangePasswordUseCaseTest.verifyAccessorIsOwnerOfAccount);
    test("verifies valid results", ChangePasswordUseCaseTest.verifyResults);
  });
}
