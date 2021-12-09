import 'package:models/shared/domain_driven_design/entity.dart';

///
/// join_request_id.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class JoinRequestID extends UUID {
  JoinRequestID(String id) : super(id);

  @override
  Map<String, dynamic> get toMap => {"joinRequestID": id};
}
