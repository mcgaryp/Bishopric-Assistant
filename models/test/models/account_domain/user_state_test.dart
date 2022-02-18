import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';

///
/// user_state_test.dart
///
///
/// Created by Porter McGary on 2/11/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class UserStateTests {
  static verifyLessThan() {
    expect(UserState.loadingIn < UserState.loadingIn, false);
    expect(UserState.loadingIn < UserState.unauthenticated, true);
    expect(UserState.loadingIn < UserState.authenticated, true);
    expect(UserState.loadingIn < UserState.noOrganization, true);
    expect(UserState.loadingIn < UserState.inOrganization, true);
    expect(UserState.unauthenticated < UserState.loadingIn, false);
    expect(UserState.unauthenticated < UserState.unauthenticated, false);
    expect(UserState.unauthenticated < UserState.authenticated, true);
    expect(UserState.unauthenticated < UserState.noOrganization, true);
    expect(UserState.unauthenticated < UserState.inOrganization, true);
    expect(UserState.authenticated < UserState.loadingIn, false);
    expect(UserState.authenticated < UserState.unauthenticated, false);
    expect(UserState.authenticated < UserState.authenticated, false);
    expect(UserState.authenticated < UserState.noOrganization, true);
    expect(UserState.authenticated < UserState.inOrganization, true);
    expect(UserState.noOrganization < UserState.loadingIn, false);
    expect(UserState.noOrganization < UserState.unauthenticated, false);
    expect(UserState.noOrganization < UserState.authenticated, false);
    expect(UserState.noOrganization < UserState.noOrganization, false);
    expect(UserState.noOrganization < UserState.inOrganization, true);
    expect(UserState.inOrganization < UserState.loadingIn, false);
    expect(UserState.inOrganization < UserState.unauthenticated, false);
    expect(UserState.inOrganization < UserState.authenticated, false);
    expect(UserState.inOrganization < UserState.noOrganization, false);
    expect(UserState.inOrganization < UserState.inOrganization, false);
  }

  static verifyLessThanOrEqualsTo() {
    expect(UserState.loadingIn <= UserState.loadingIn, true);
    expect(UserState.loadingIn <= UserState.unauthenticated, true);
    expect(UserState.loadingIn <= UserState.authenticated, true);
    expect(UserState.loadingIn <= UserState.noOrganization, true);
    expect(UserState.loadingIn <= UserState.inOrganization, true);
    expect(UserState.unauthenticated <= UserState.loadingIn, false);
    expect(UserState.unauthenticated <= UserState.unauthenticated, true);
    expect(UserState.unauthenticated <= UserState.authenticated, true);
    expect(UserState.unauthenticated <= UserState.noOrganization, true);
    expect(UserState.unauthenticated <= UserState.inOrganization, true);
    expect(UserState.authenticated <= UserState.loadingIn, false);
    expect(UserState.authenticated <= UserState.unauthenticated, false);
    expect(UserState.authenticated <= UserState.authenticated, true);
    expect(UserState.authenticated <= UserState.noOrganization, true);
    expect(UserState.authenticated <= UserState.inOrganization, true);
    expect(UserState.noOrganization <= UserState.loadingIn, false);
    expect(UserState.noOrganization <= UserState.unauthenticated, false);
    expect(UserState.noOrganization <= UserState.authenticated, false);
    expect(UserState.noOrganization <= UserState.noOrganization, true);
    expect(UserState.noOrganization <= UserState.inOrganization, true);
    expect(UserState.inOrganization <= UserState.loadingIn, false);
    expect(UserState.inOrganization <= UserState.unauthenticated, false);
    expect(UserState.inOrganization <= UserState.authenticated, false);
    expect(UserState.inOrganization <= UserState.noOrganization, false);
    expect(UserState.inOrganization <= UserState.inOrganization, true);
  }

  static verifyGreaterThan() {
    expect(UserState.loadingIn > UserState.loadingIn, false);
    expect(UserState.loadingIn > UserState.unauthenticated, false);
    expect(UserState.loadingIn > UserState.authenticated, false);
    expect(UserState.loadingIn > UserState.noOrganization, false);
    expect(UserState.loadingIn > UserState.inOrganization, false);
    expect(UserState.unauthenticated > UserState.loadingIn, true);
    expect(UserState.unauthenticated > UserState.unauthenticated, false);
    expect(UserState.unauthenticated > UserState.authenticated, false);
    expect(UserState.unauthenticated > UserState.noOrganization, false);
    expect(UserState.unauthenticated > UserState.inOrganization, false);
    expect(UserState.authenticated > UserState.loadingIn, true);
    expect(UserState.authenticated > UserState.unauthenticated, true);
    expect(UserState.authenticated > UserState.authenticated, false);
    expect(UserState.authenticated > UserState.noOrganization, false);
    expect(UserState.authenticated > UserState.inOrganization, false);
    expect(UserState.noOrganization > UserState.loadingIn, true);
    expect(UserState.noOrganization > UserState.unauthenticated, true);
    expect(UserState.noOrganization > UserState.authenticated, true);
    expect(UserState.noOrganization > UserState.noOrganization, false);
    expect(UserState.noOrganization > UserState.inOrganization, false);
    expect(UserState.inOrganization > UserState.loadingIn, true);
    expect(UserState.inOrganization > UserState.unauthenticated, true);
    expect(UserState.inOrganization > UserState.authenticated, true);
    expect(UserState.inOrganization > UserState.noOrganization, true);
    expect(UserState.inOrganization > UserState.inOrganization, false);
  }

  static verifyGreaterThanOrEqualsTo() {
    expect(UserState.loadingIn >= UserState.loadingIn, true);
    expect(UserState.loadingIn >= UserState.unauthenticated, false);
    expect(UserState.loadingIn >= UserState.authenticated, false);
    expect(UserState.loadingIn >= UserState.noOrganization, false);
    expect(UserState.loadingIn >= UserState.inOrganization, false);
    expect(UserState.unauthenticated >= UserState.loadingIn, true);
    expect(UserState.unauthenticated >= UserState.unauthenticated, true);
    expect(UserState.unauthenticated >= UserState.authenticated, false);
    expect(UserState.unauthenticated >= UserState.noOrganization, false);
    expect(UserState.unauthenticated >= UserState.inOrganization, false);
    expect(UserState.authenticated >= UserState.loadingIn, true);
    expect(UserState.authenticated >= UserState.unauthenticated, true);
    expect(UserState.authenticated >= UserState.authenticated, true);
    expect(UserState.authenticated >= UserState.noOrganization, false);
    expect(UserState.authenticated >= UserState.inOrganization, false);
    expect(UserState.noOrganization >= UserState.loadingIn, true);
    expect(UserState.noOrganization >= UserState.unauthenticated, true);
    expect(UserState.noOrganization >= UserState.authenticated, true);
    expect(UserState.noOrganization >= UserState.noOrganization, true);
    expect(UserState.noOrganization >= UserState.inOrganization, false);
    expect(UserState.inOrganization >= UserState.loadingIn, true);
    expect(UserState.inOrganization >= UserState.unauthenticated, true);
    expect(UserState.inOrganization >= UserState.authenticated, true);
    expect(UserState.inOrganization >= UserState.noOrganization, true);
    expect(UserState.inOrganization >= UserState.inOrganization, true);
  }
}

runUserStateTests() {
  group("User State Tests", () {
    test("Verify greater than", UserStateTests.verifyGreaterThan);
    test("Verify less than", UserStateTests.verifyLessThan);
    test("Verify greater than or equals to",
        UserStateTests.verifyGreaterThanOrEqualsTo);
    test("Verify less than or equals to",
        UserStateTests.verifyLessThanOrEqualsTo);
  });
}
