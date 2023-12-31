import 'package:models/models/organization.dart';

///
/// has_associated_organization_use_case.dart
///
///
/// Created by Porter McGary on 12/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin HasAssociatedOrganizationUseCase {
  @required
  Future<OrganizationMember?> execute({required AccountID accountID});
}

class DefaultHasAssociatedOrganizationUseCase
    implements HasAssociatedOrganizationUseCase {
  final MemberRepository _memberRepository;

  DefaultHasAssociatedOrganizationUseCase(this._memberRepository);

  @override
  Future<OrganizationMember?> execute({required AccountID accountID}) async {
    // find member associated with account
    List<Member> members =
        await _memberRepository.findAllWithAccountID(accountID);

    if (members.isEmpty) return null;

    // for each member
    for (Member member in members) {
      Organization? organization =
          await _memberRepository.findOrganization(member.id);
      // if there is one member who has a valid member organization relationship
      if (organization != null)
        return OrganizationMember(member: member, organization: organization);
    }
    // else false
    return null;
  }
}
