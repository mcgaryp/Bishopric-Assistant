import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/repository.dart';

///
/// member_repository.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/2/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [MemberRepository] manages the data of a repository regarding membership
mixin MemberRepository implements Repository<Member, MemberID, OrganizationID> {
  Future<Organization?> findOrganization(MemberID memberID);

  Future<Member?> findWithAccountID(AccountID accountID);

  Stream<List<Stream<Member>>> findAll(OrganizationID organizationID);

  Future<List<Member>?> findAllWithAccountID(AccountID accountID);
}
