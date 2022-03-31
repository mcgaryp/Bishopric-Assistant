import 'package:models/models/organization.dart';

import 'mock_member.dart';
import 'mock_organization.dart';

///
/// mock_member_repository.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 2/2/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class MockMemberRepository implements MemberRepository {
  bool findFlag = false;
  bool findAllFlag = false;
  bool findAllStreamedFlag = false;
  bool findAllWithAccountIDFlag = false;
  bool findOrganizationFlag = false;
  bool findStreamedFlag = false;
  bool findWithAccountIDFlag = false;
  bool insertFlag = false;
  bool removeFlag = false;
  bool updateFlag = false;

  final Member member;
  final Organization organization;
  final bool shouldSucceed;

  MockMemberRepository(
      {Member? member, Organization? organization, this.shouldSucceed = true})
      : this.member = member ?? MockMember(id: MockMemberID().id).member,
        this.organization = organization ??
            MockOrganization(id: MockOrganizationID().id).organization;

  @override
  Future<Member?> find(MemberID id) {
    findFlag = true;
    if (member.id == id) return Future.value(member);
    return Future.value(null);
  }

  @override
  Future<List<Member>> findAll(OrganizationID organizationID) {
    findAllFlag = true;
    return Future.value(List.filled(2, member));
  }

  @override
  Future<List<Member>> findAllWithAccountID(AccountID accountID) {
    findAllWithAccountIDFlag = true;
    return Future.value(List.filled(2, member));
  }

  @override
  Future<Organization?> findOrganization(MemberID memberID) {
    findOrganizationFlag = true;
    if (memberID == organization.creator.id) return Future.value(organization);
    return Future.value(null);
  }

  @override
  Future<Member?> findWithAccountID(AccountID accountID) {
    findWithAccountIDFlag = true;
    if (shouldSucceed) return Future.value(member);
    return Future.value(null);
  }

  @override
  Future<bool> insert(
      Member member, OrganizationID organizationID, AccountID accountID) {
    insertFlag = true;
    return Future.value(shouldSucceed);
  }

  @override
  Future<bool> remove(MemberID i) {
    removeFlag = true;
    return Future.value(shouldSucceed);
  }

  @override
  Future<bool> update(Member m) {
    updateFlag = true;
    return Future.value(shouldSucceed);
  }
}
