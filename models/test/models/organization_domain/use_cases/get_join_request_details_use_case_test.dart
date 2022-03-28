import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account_repository.dart';
import '../../../mocks/organization/mock_join_request.dart';

///
/// get_join_request_details_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class GetJoinRequestDetailsUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  static void verifyFunctionRepoCalls() async {
    MockAccountRepository accountRepo = MockAccountRepository();
    GetJoinRequestDetailsUseCase useCase =
        DefaultGetJoinRequestDetailsUseCase(accountRepo);

    await useCase.execute(MockJoinRequest().request);

    expect(accountRepo.activateFlag, false);
    expect(accountRepo.findFlag, true);
    expect(accountRepo.findByEmailFlag, false);
    expect(accountRepo.findByPhoneFlag, false);
    expect(accountRepo.findByUsernameFlag, false);
    expect(accountRepo.findStreamedFlag, false);
    expect(accountRepo.insertFlag, false);
    expect(accountRepo.loginFlag, false);
    expect(accountRepo.logoutFlag, false);
    expect(accountRepo.deactivateFlag, false);
    expect(accountRepo.updateFlag, false);
  }

  // TODO: VERIFY PERMISSIONS ?
  static void verifyPermissions() async {
    // Verify that the accessor is a member of the organization
  }

  // TODO: VERIFY RESULTS ?
  static void verifyResults() async {
    // return name of those requesting to join
    // throws error if fails
  }
}

runGetJoinRequestDetailsUseCaseTest() {
  group("Get Join Request Details Use Case Test", () {
    test("Verify repo function calls",
        GetJoinRequestDetailsUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions",
        GetJoinRequestDetailsUseCaseTest.verifyPermissions);
    test("verify results", GetJoinRequestDetailsUseCaseTest.verifyResults);
  });
}
