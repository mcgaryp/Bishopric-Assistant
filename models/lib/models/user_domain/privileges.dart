///
/// privileges.dart
/// bishopric-assistant
///
/// Created by porter on 9/27/21
/// Copyright 2021 porter. All rights reserved.
///

class Privileges {
  final bool canChangeRoles;
  final bool canRemoveMembers;
  final bool canAddMembers;

  Privileges(this.canChangeRoles, this.canRemoveMembers, this.canAddMembers);
}
