import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/account/mock_account_repository.dart';

///
/// reactivate_account_use_case_tests.dart
///
///
/// Created by Porter McGary on 2/11/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class ReactivateAccountUseCaseTests {
  // REPO FUNCTION CALLS
  // - account repo
  //   - calls activate
  static void verifyFunctionRepoCalls() async {
    MockAccountRepository mockRepo = MockAccountRepository(
        account: MockAccount(id: MockAccountID().id).account);
    ReactivateAccountUseCase useCase =
        DefaultReactivateAccountUseCase(mockRepo);

    await useCase.execute(MockAccountID().id);

    expect(mockRepo.activateFlag, true);

    expect(mockRepo.findFlag, false);

    expect(mockRepo.findByEmailFlag, false);

    expect(mockRepo.findByPhoneFlag, false);

    expect(mockRepo.findByUsernameFlag, false);

    expect(mockRepo.findStreamedFlag, false);

    expect(mockRepo.insertFlag, false);

    expect(mockRepo.loginFlag, false);

    expect(mockRepo.logoutFlag, false);

    expect(mockRepo.deactivateFlag, false);

    expect(mockRepo.updateFlag, false);
  }

  // TODO VERIFY PERMISSIONS
  // - verify that the user is who they say they are
  static void verifyPermissions() async {
    // This at the moment is not checked in the current version. More thought as
    //    to how this needs to be done is necessary before writing a unit test
  }

  // VERIFY RESULTS
  // - if successful return true
  // - else false
  static void verifyResults() async {
    // expected
    MockAccountRepository mockRepo = MockAccountRepository(
        account: MockAccount(id: MockAccountID().id).account);
    ReactivateAccountUseCase useCase =
        DefaultReactivateAccountUseCase(mockRepo);

    bool result = await useCase.execute(MockAccountID().id);
    expect(result, true);

    // expected fail
    mockRepo = MockAccountRepository(
        account: MockAccount(id: MockAccountID().id).account, shouldFail: true);
    useCase = DefaultReactivateAccountUseCase(mockRepo);

    result = await useCase.execute(MockAccountID().id);
    expect(result, false);
  }
}

runReactivateAccountUseCaseTests() {
  group("ReactivateAccountUseCaseTests", () {
    test("verify repo function calls",
        ReactivateAccountUseCaseTests.verifyFunctionRepoCalls);
    test("verify permissions", ReactivateAccountUseCaseTests.verifyPermissions);
    test("verify results", ReactivateAccountUseCaseTests.verifyResults);
  });
}
