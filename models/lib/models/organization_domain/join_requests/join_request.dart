import 'package:models/models/organization.dart';
import 'package:models/models/organization_domain/join_requests/join_request_id.dart';
import 'package:models/shared/foundation.dart';

///
/// join_request.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/8/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class JoinRequest extends Entity<JoinRequest> {
  final JoinRequestID id;
  final AccountID accountID;
  final OrganizationID organizationID;
  static const _accountIDKey = "accountID";
  static const _organizationIDKey = "organizationID";

  JoinRequest(
      {required this.accountID, required this.organizationID, required this.id})
      : super(id);

  JoinRequest.fromMap(Map<String, dynamic> map, JoinRequestID id)
      : this(
            id: id,
            accountID: AccountID(map[_accountIDKey]),
            organizationID: OrganizationID(map[_organizationIDKey]));

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != JoinRequest) return false;
    return sameIdentityAs(other as JoinRequest);
  }

  @override
  Map<String, dynamic> get toMap =>
      {_accountIDKey: accountID.id, _organizationIDKey: organizationID.id};

  @override
  bool sameIdentityAs(JoinRequest other) {
    return this.accountID == other.accountID &&
        this.organizationID == other.organizationID &&
        this.id == other.id;
  }
}
