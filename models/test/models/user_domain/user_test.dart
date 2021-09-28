import 'current_user_test.dart';
import 'generic_user_test.dart';
import 'member_user_test.dart';
import 'user_id_test.dart';

///
/// user_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

class UserTest {}

runUserTests() {
  runUserIDTests();
  runGenericUserTests();
  runMemberUserTests();
  runCurrentUserTests();
}
