import 'package:models/models/organization.dart';

///
/// $mock_authorization.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockAuthorization {
  final Authorization authorization;

  MockAuthorization({String name = "Temp Authorization", int rank = 0})
      : this.authorization = Authorization(name: name, rank: rank);

  static Authorization get Unclassified =>
      Authorization(name: "Unclassified", rank: 0);

  static Authorization get Protected =>
      Authorization(name: "Protected", rank: 1);

  static Authorization get Confidential =>
      Authorization(name: "Confidential", rank: 2);

  static Authorization get TopSecret =>
      Authorization(name: "TopSecret", rank: 3);
}
