import 'package:models/models/organization.dart';

///
/// organization_member.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/8/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class OrganizationMember {
  final Organization organization;
  final Member member;

  OrganizationMember({required this.member, required this.organization});

  @override
  String toString() {
    return """
    $organization
    
    $member
    """;
  }
}
