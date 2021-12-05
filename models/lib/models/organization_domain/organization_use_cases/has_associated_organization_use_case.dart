import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// has_associated_organization_use_case.dart
///
///
/// Created by Porter McGary on 12/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin HasAssociatedOrganizationUseCase {
  @required
  Future<Organization?> execute({required AccountID accountID});
}

class DefaultHasAssociatedOrganizationUseCase
    implements HasAssociatedOrganizationUseCase {
  final MemberRepository _memberRepository;

  DefaultHasAssociatedOrganizationUseCase(this._memberRepository);

  @override
  Future<Organization?> execute({required AccountID accountID}) async {
    // find members associated with account
    List<Member>? members =
        await _memberRepository.findAllWithAccountID(accountID);
    if (members == null) return null;
    // for each member
    for (Member member in members) {
      Organization? organization =
          await _memberRepository.findOrganization(member.memberID);
      // if there is one member who has a valid member organization relationship
      // return true
      if (organization != null) return organization;
    }
    // else false
    return null;
  }
}
