import 'package:models/shared/uuid.dart';

///
/// organization_id.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// [OrganizationID] unique identifier for each Organization created
class OrganizationID extends UUID {
  OrganizationID(String id) : super(id);

  @override
  bool sameValueAs(UUID other) {
    return other.id == this.id;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != OrganizationID) return false;
    return sameValueAs(other as OrganizationID);
  }

  @override
  Map<String, dynamic> get toMap => throw UnimplementedError();
}
