import 'package:models/models/organization_domain/roles/role.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/24/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

extension RoleListExtension on List<Role> {
  Role find(int hashCode) =>
      this.firstWhere((Role role) => role.id.id.hashCode == hashCode);
}