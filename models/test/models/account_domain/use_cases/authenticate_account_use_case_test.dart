import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/account/mock_account_repository.dart';
import '../../../mocks/account/mock_credentials.dart';

///
/// authenticate_account_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class AuthenticateAccountUseCaseTest with Test {
  // REPO FUNCTION CALLS
  // - Account Repo
  //   - calls findByUserName
  //   - calls login
  static void verifyRepositoryFunctionCalls() async {
    MockAccountRepository mockRepo = MockAccountRepository();
    AuthenticateAccountUseCase useCase =
        DefaultAuthenticateAccountUseCase(mockRepo);

    Credentials credentials = MockCredentials().credentials;
    await useCase.execute(credentials);

    expect(mockRepo.findByUsernameFlag, true);
    expect(mockRepo.loginFlag, true);

    expect(mockRepo.activateFlag, false);
    expect(mockRepo.findFlag, false);
    expect(mockRepo.findByEmailFlag, false);
    expect(mockRepo.findByPhoneFlag, false);
    expect(mockRepo.findStreamedFlag, false);
    expect(mockRepo.insertFlag, false);
    expect(mockRepo.logoutFlag, false);
    expect(mockRepo.deactivateFlag, false);
    expect(mockRepo.updateFlag, false);
  }

  // CHECK PERMISSIONS
  // - Checks password as a match
  static void verifyProperPermissions() async {
    // There is nothing yet to verify here. maybe in the future a function will
    //    be created to verify this. as of right now an equivalency operator can
    //    be used or `sameEntityAs()` function
  }

  // CHECK RESULTS
  // - returns an account or throws proper errors
  static void verifyResults() async {
    // Expected positive results
    MockAccountRepository mockRepo = MockAccountRepository();
    AuthenticateAccountUseCase useCase =
        DefaultAuthenticateAccountUseCase(mockRepo);

    Credentials credentials = MockAccount().account.credentials;
    Account account = await useCase.execute(credentials);

    expect(account.credentials, credentials);

    // With incorrect username
    try {
      await useCase
          .execute(MockCredentials(username: "My Stinky Farts").credentials);
      Test.fallthrough();
    } catch (error) {
      expect(
          error.toString(),
          PermissionDeniedError(reason: "Incorrect Username or Password")
              .toString());
    }

    // With incorrect password
    try {
      await useCase
          .execute(MockCredentials(password: "My Stinky Farts").credentials);
      Test.fallthrough();
    } catch (error) {
      expect(
          error.toString(),
          PermissionDeniedError(reason: "Incorrect Username or Password")
              .toString());
    }
  }
}

runAuthenticateAccountTests() {
  group("Account Authentication", () {
    test("repository function calls are made",
        AuthenticateAccountUseCaseTest.verifyRepositoryFunctionCalls);
    test("proper user permissions are verified",
        AuthenticateAccountUseCaseTest.verifyProperPermissions);
    test(
        "an Account is returned", AuthenticateAccountUseCaseTest.verifyResults);
  });
}
