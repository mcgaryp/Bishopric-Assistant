import 'package:models/shared/exceptions/for_object_exception.dart';

///
/// id_does_not_exist_error.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class IdDoesNotExistError extends ForObjectException {
  IdDoesNotExistError({String? forObject})
      : super("The ID does not exist", forObject: forObject);
}
