import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';

import '../../../mocks/account/mock_account_repository.dart';

///
/// logout_account_use_case_tests.dart
///
///
/// Created by Porter McGary on 2/11/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class LogoutAccountUseCaseTests {
  // REPO FUNCTION CALLS
  // - account repo
  //   - calls logout
  static void verifyFunctionRepoCalls() async {
    MockAccountRepository mockRepo = MockAccountRepository();
    LogoutAccountUseCase useCase = DefaultLogoutAccountUseCase(mockRepo);

    await useCase.execute();

    expect(mockRepo.activateFlag, false);

    expect(mockRepo.findFlag, false);

    expect(mockRepo.findByEmailFlag, false);

    expect(mockRepo.findByPhoneFlag, false);

    expect(mockRepo.findByUsernameFlag, false);

    expect(mockRepo.findStreamedFlag, false);

    expect(mockRepo.insertFlag, false);

    expect(mockRepo.loginFlag, false);

    expect(mockRepo.logoutFlag, true);

    expect(mockRepo.deactivateFlag, false);

    expect(mockRepo.updateFlag, false);
  }

  // VERIFY PERMISSIONS
  static void verifyPermissions() async {
    // No permissions at this time to check
  }

  // VERIFY RESULTS
  // - successful returns a true
  // - failure returns a false
  static void verifyResults() async {
    MockAccountRepository mockRepo = MockAccountRepository();
    LogoutAccountUseCase useCase = DefaultLogoutAccountUseCase(mockRepo);

    bool result = await useCase.execute();
    expect(result, true);

    mockRepo = MockAccountRepository(shouldFail: true);
    useCase = DefaultLogoutAccountUseCase(mockRepo);

    result = await useCase.execute();
    expect(result, false);
  }
}

runLogoutAccountUseCaseTests() {
  group("LogoutAccountUseCaseTests", () {
    test("verify function repo calls",
        LogoutAccountUseCaseTests.verifyFunctionRepoCalls);
    test("verify permissions", LogoutAccountUseCaseTests.verifyPermissions);
    test("verify results", LogoutAccountUseCaseTests.verifyResults);
  });
}
