import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/member_domain/member_id.dart';

///
/// member_id_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberIDTest {
  static void shouldReturnValidIDWhenValidID() {
    MemberID memberId = MemberID("9");
    String result = memberId.id;
    expect(result, 9);
  }
}

runMemberIDTests() {
  group("Member ID", () {
    test("should return valid ID", MemberIDTest.shouldReturnValidIDWhenValidID);
  });
}
