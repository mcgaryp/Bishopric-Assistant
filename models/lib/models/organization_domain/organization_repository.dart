import 'package:models/models/organization.dart';
import 'package:models/shared/repository.dart';

///
/// organization_repository.dart
/// bishopric-assistant
///
/// Created by Po. on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Implement Event, Refer to [ReadMe.md](old_models_deprecated/README.md)
/// TODO: Comment
mixin OrganizationRepository
    implements Repository<Organization, OrganizationID, void> {
  @required
  Future<Member?> findMember(MemberID id);

  // add member to organization
  @required
  Future<Member?> addMember(MemberID memberID, OrganizationID organizationID);

  // insert member
  @required
  Future<bool> insertMember(Member member);

  // remove member
  @required
  Future<Result<bool>> removeMember(MemberID id);

  // update the member
  @required
  Future<bool> updateMember(Member member);

  @required
  Future<MemberID?> generateNextMemberId();
}
