import 'package:models/models/account_domain/account_id.dart';
import 'package:models/shared/exceptions/for_object_exception.dart';

///
/// inactive_account_error.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class InactiveAccountError extends ForObjectException {
  final AccountID id;

  InactiveAccountError(this.id, {String? forObject})
      : super("Deactivated Account", forObject: forObject);
}
