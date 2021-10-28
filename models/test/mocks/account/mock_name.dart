import 'package:models/models/account.dart';

///
/// mock_name.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class MockName {
  static final String mockFirst = "First";
  static final String mockLast = "Last";

  late final Name name;

  MockName({String? first, String? last}) {
    name = Name(first: first ?? mockFirst, last: last ?? mockLast);
  }
}
