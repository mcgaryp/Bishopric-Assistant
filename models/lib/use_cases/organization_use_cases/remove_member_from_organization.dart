import 'package:models/models/member.dart';

///
/// remove_member_from_organization.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

mixin RemoveMemberFromOrganization {
  @required
  Future<Result> execute(MemberID memberID);
}

class DefaultRemoveMemberFromOrganization
    implements RemoveMemberFromOrganization {
  MemberRepository _memberRepository;

  DefaultRemoveMemberFromOrganization(this._memberRepository);

  @override
  Future<Result> execute(MemberID memberID) async {
    Result result = await _memberRepository.remove(memberID);
    return result;
  }
}
