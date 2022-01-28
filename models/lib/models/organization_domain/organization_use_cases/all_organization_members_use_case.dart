import 'package:models/models/organization.dart';

///
/// all_organization_members.dart
///
///
/// Created by Porter McGary on 12/15/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin AllOrganizationMembersUseCase {
  @required
  Stream<List<Stream<Member>>> execute(OrganizationID id);
}

class DefaultAllOrganizationMembersUseCase
    implements AllOrganizationMembersUseCase {
  final MemberRepository _memberRepository;

  DefaultAllOrganizationMembersUseCase(this._memberRepository);

  @override
  Stream<List<Stream<Member>>> execute(OrganizationID id) {
    return _memberRepository.findAllStreamed(id);
  }
}
