import 'package:models/models/organization.dart';

///
/// member_repository.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/2/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [MemberRepository] manages the data of a repository regarding membership
mixin MemberRepository {
  @required
  Future<Member?> find(MemberID id);

  @required
  Future<List<Member>> findAll(OrganizationID id);

  @required
  Future<Organization?> findOrganization(MemberID id);

  @required
  Future<Member?> findWithAccountID(AccountID id);

  @required
  Future<List<Member>> findAllWithAccountID(AccountID accountID);

  @required
  Future<bool> insert(
      Member member, OrganizationID organizationID, AccountID accountID);

  @required
  Future<bool> remove(MemberID id);

  @required
  Future<bool> update(Member member);
}
