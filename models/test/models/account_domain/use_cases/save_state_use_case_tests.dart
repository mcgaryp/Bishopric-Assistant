import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';

import '../../../mocks/account/mock_state_repository.dart';

///
/// save_state_use_case_tests.dart
///
///
/// Created by Porter McGary on 2/11/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class SaveStateUseCaseTests {
  // REPO FUNCTION CALLS
  // TODO: rethink function calls
  // - user state repo
  //   - calls insert
  static void verifyFunctionRepoCalls() async {
    MockStateRepository repo = MockStateRepository();

    SaveStateUseCase useCase = DefaultSaveStateUseCase(repo);
    await useCase.execute(UserState.authenticated);

    expect(repo.findFlag, false);
    expect(repo.insertFlag, true);
    expect(repo.removeFlag, false);
    expect(repo.updateFlag, false);
  }

  // VERIFY PERMISSIONS
  static void verifyPermissions() async {
    // No permissions to verify at this time
  }

  // VERIFY RESULTS
  // - true is successful
  // - false if not successful
  static void verifyResults() async {
    MockStateRepository repo = MockStateRepository();

    SaveStateUseCase useCase = DefaultSaveStateUseCase(repo);
    bool result = await useCase.execute(UserState.authenticated);
    expect(result, true);

    repo = MockStateRepository(shouldSucceed: false);

    useCase = DefaultSaveStateUseCase(repo);
    result = await useCase.execute(UserState.authenticated);
    expect(result, false);
  }
}

runSaveStateUseCaseTests() {
  group("SaveStateUseCaseTests", () {
    test("verify function repo calls",
        SaveStateUseCaseTests.verifyFunctionRepoCalls);
    test("verify permissions", SaveStateUseCaseTests.verifyPermissions);
    test("verify results", SaveStateUseCaseTests.verifyResults);
  });
}
