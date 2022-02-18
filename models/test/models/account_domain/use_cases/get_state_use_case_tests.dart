import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';

import '../../../mocks/account/mock_state_repository.dart';

///
/// get_state_use_case_tests.dart
///
///
/// Created by Porter McGary on 2/11/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class GetStateUseCaseTests {
  // REPO FUNCTION CALLS
  // - uses state repo
  //   - calls find
  static void verifyFunctionRepoCalls() async {
    MockStateRepository repo = MockStateRepository();

    GetStateUseCase useCase = DefaultGetStateUseCase(repo);
    await useCase.execute();

    expect(repo.findFlag, true);
    expect(repo.insertFlag, false);
    expect(repo.removeFlag, false);
    expect(repo.updateFlag, false);
  }

  // VERIFY PERMISSIONS
  static void verifyPermissions() async {
    // There are no permissions at this time to verify
  }

  // VERIFY RESULTS
  // - Successful returns a state
  static void verifyResults() async {
    MockStateRepository repo =
        MockStateRepository(userState: UserState.authenticated);

    GetStateUseCase useCase = DefaultGetStateUseCase(repo);
    UserState result = await useCase.execute();
    expect(result, UserState.authenticated);
  }
}

runGetStateUseCaseTests() {
  group("GetStateUseCaseTests", () {
    test("Verify repo function calls",
        GetStateUseCaseTests.verifyFunctionRepoCalls);
    test("verify permissions", GetStateUseCaseTests.verifyPermissions);
    test("verify results", GetStateUseCaseTests.verifyResults);
  });
}
