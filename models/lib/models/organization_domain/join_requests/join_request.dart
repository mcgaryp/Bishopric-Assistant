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
  final JoinRequestID? id;
  final AccountID accountID;
  final OrganizationID organizationID;
  static const accountIDKey = "Join Request Account ID";
  static const organizationIDKey = "Join Request Organization ID";
  static const idKey = "Join Request ID";

  JoinRequest({required this.accountID, required this.organizationID, this.id})
      : super(JoinRequestID("Invalid ID"));

  JoinRequest.fromMap(Map<String, dynamic> map)
      : this(
            id: JoinRequestID(map[idKey]),
            accountID: AccountID(map[accountIDKey]),
            organizationID: OrganizationID(map[organizationIDKey]));

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != JoinRequest) return false;
    return sameIdentityAs(other as JoinRequest);
  }

  @override
  Map<String, dynamic> get toMap => {
        accountIDKey: accountID.id,
        organizationIDKey: organizationID.id,
        idKey: id?.id
      };

  @override
  bool sameIdentityAs(JoinRequest other) {
    return this.accountID == other.accountID &&
        this.organizationID == other.organizationID &&
        this.id == other.id;
  }
}
