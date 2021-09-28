import 'package:models/models/user_domain/user.dart';
import 'package:models/shared/repository.dart';

import 'user_id.dart';

///
/// user_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Implement UserRepository, Refer to [ReadMe.md](models/README.md)
/// [UserRepository] implements [Repository]. Interface should be implemented as
/// an integration database class
@Deprecated("Use Accounts")
mixin UserRepository implements Repository<User, UserID, void> {}
