import 'for_object_exception.dart';

///
/// invalid_password_error.dart
/// bishopric-assistant
///
/// Created by chandlerowen on 12/8/21
/// Copyright 2021 chandlerowen. All rights reserved.
///

class InvalidPasswordError extends ForObjectException {
  InvalidPasswordError(InvalidPasswordCase error, {String? forObject})
      : super(error.string, forObject: forObject);
}

enum InvalidPasswordCase { settingPasswordSameAsPrevious }

extension InvalidPasswordCaseExtension on InvalidPasswordCase {
  String get string {
    switch (this) {
      case InvalidPasswordCase.settingPasswordSameAsPrevious:
        return "Password Cannot Be Identical To Previous Password";
    }
  }
}
