import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

///
/// all_assignees_use_case.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/7/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

mixin AllAssigneesUseCase {
  @required
  Future<List<Assignee>> execute(OrganizationID organizationID);
}

class DefaultAllAssigneesUseCase implements AllAssigneesUseCase {
  final MemberRepository _memberRepository;

  DefaultAllAssigneesUseCase(this._memberRepository);

  @override
  Future<List<Assignee>> execute(OrganizationID organizationID) async {
    List<Member> list = await _memberRepository.findAll(organizationID);
    return list.map((e) => Assignee.fromMember(e)).toList();
  }
}
