import 'package:models/models/organization.dart';
import 'package:models/shared/repository.dart';

import 'role.dart';
import 'role_id.dart';

///
/// role_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

mixin RoleRepository implements Repository<Role, RoleID, OrganizationID> {}
