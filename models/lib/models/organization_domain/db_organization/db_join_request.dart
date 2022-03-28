import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/17/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DBJoinRequest {
  static const accountIDKey = "Join Request Account ID";
  static const organizationIDKey = "Join Request Organization ID";
  static const idKey = "Join Request ID";

  String? organizationID;
  String? requestID;
  String? accountID;

  DBJoinRequest({this.requestID, this.accountID, this.organizationID});

  DBJoinRequest.fromMap(Map<String, dynamic> map)
      : this(
          requestID: map[idKey],
          accountID: map[accountIDKey],
          organizationID: map[organizationIDKey],
        );

  DBJoinRequest.fromJoinRequest(JoinRequest request)
      : this(
          accountID: request.accountID.id,
          organizationID: request.organizationID.id,
        );

  Map<String, dynamic> get toMap => {
        idKey: requestID,
        organizationIDKey: organizationID,
        accountIDKey: accountID,
      };

  AccountID get toAccountID {
    accountID ??
        (throw IdDoesNotExistError(forObject: "DB Join Request Account ID"));
    return AccountID(accountID!);
  }

  OrganizationID get toOrganizationID {
    accountID ??
        (throw IdDoesNotExistError(
            forObject: "DB Join Request Organization ID"));
    return OrganizationID(organizationID!);
  }

  JoinRequestID get toJoinRequestID {
    accountID ?? (throw IdDoesNotExistError(forObject: "DB Join Request ID"));
    return JoinRequestID(requestID!);
  }

  JoinRequest get toJoinRequest => JoinRequest(
        accountID: toAccountID,
        organizationID: toOrganizationID,
        id: toJoinRequestID,
      );
}
