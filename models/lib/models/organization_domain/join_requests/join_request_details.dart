import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

///
/// join_request_details.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/8/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class JoinRequestDetail {
  final Name name;
  final JoinRequest request;

  JoinRequestDetail({required this.name, required this.request});
}
