import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// join_request.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/8/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class JoinRequest extends Entity<JoinRequest> {
  static const accountIDKey = "Join Request Account ID";
  static const organizationIDKey = "Join Request Organization ID";
  static const idKey = "Join Request ID";

  final JoinRequestID? _id;
  final AccountID accountID;
  final OrganizationID organizationID;

  JoinRequest({required this.accountID, required this.organizationID, JoinRequestID? id})
      : this._id = id, super(JoinRequestID("Invalid ID"));

  JoinRequest.fromMap(Map<String, dynamic> map)
      : this(
            id: JoinRequestID(map[idKey]),
            accountID: AccountID(map[accountIDKey]),
            organizationID: OrganizationID(map[organizationIDKey]));

  JoinRequestID get id {
    _id ?? (throw IdDoesNotExistError(forObject: "Join Request ID"));
    return _id!;
  }

  @override
  Map<String, dynamic> get toMap => {
    accountIDKey: accountID.id,
    organizationIDKey: organizationID.id,
    idKey: _id?.id
  };

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != JoinRequest) return false;
    return sameIdentityAs(other as JoinRequest);
  }

  @override
  bool sameIdentityAs(JoinRequest other) {
    return this.accountID == other.accountID &&
        this.organizationID == other.organizationID &&
        this.id == other.id;
  }
}
