import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/user.dart';
import 'package:models/shared/exceptions.dart';

///
/// user_id_test.dart
/// bishopric-assistant
///
/// Created by porter on 9/27/21
/// Copyright 2021 porter. All rights reserved.
///

class UserIDTest {
  static shouldReturnIdWhenValidId() {
    // arrange
    UserID id = UserID("12");
    // act
    String result = id.id;
    // assert
    expect(result, "12");
  }

  static shouldReturnErrorWhenInvalidId() {
    // arrange
    try {
      UserID id = UserID("");
      // act
    } catch (result) {
      // assert
      expect(result.toString(), EmptyStringError().toString());
    }
  }
}

runUserIDTests() {
  group("User ID Tests", () {
    test("should return valid ID", UserIDTest.shouldReturnIdWhenValidId);
    test("should return Empty String Error",
        UserIDTest.shouldReturnErrorWhenInvalidId);
  });
}
