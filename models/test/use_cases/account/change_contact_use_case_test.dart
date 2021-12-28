import 'package:flutter_test/flutter_test.dart';
import 'package:models/shared/test.dart';

///
/// change_contact_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class ChangeContactUseCaseTest with Test {
  static void shouldReturnTrueWhenValidContactAndSuccessfulUpdate() async {
    throw UnimplementedError();
  }

  static void shouldReturnAccountNotFoundErrorWhenGivenInvalidID() async {
    throw UnimplementedError();
  }
}

runChangeContactTests() {
  group("Change Contact Tests", () {
    test(
        "should return some kind of result based on the success of the backend",
        ChangeContactUseCaseTest
            .shouldReturnTrueWhenValidContactAndSuccessfulUpdate);
    test(
        "should return account not found error when invalid id given",
        ChangeContactUseCaseTest
            .shouldReturnAccountNotFoundErrorWhenGivenInvalidID);
  });
}
