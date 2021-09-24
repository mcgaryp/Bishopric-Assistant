import 'package:models/models/member.dart';
import 'package:models/models/role.dart';

///
/// change_member_role_in_organization.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

mixin ChangeMemberRoleInOrganization {
  @required
  Future<Result> execute(MemberID memberID, RoleID roleID);
}

class DefaultChangeMemberRoleInOrganization
    implements ChangeMemberRoleInOrganization {
  MemberRepository _memberRepository;
  RoleRepository _roleRepository;

  DefaultChangeMemberRoleInOrganization(
      this._memberRepository, this._roleRepository);

  @override
  Future<Result> execute(MemberID memberID, RoleID roleID) async {
    Role newRole = await _roleRepository.find(roleID);
    Member member = await _memberRepository.find(memberID);
    Member updatedMember = Member.newRole(role: newRole, member: member);
    Result result = await _memberRepository.update(updatedMember);
    return result;
  }
}
