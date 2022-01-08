import 'package:models/shared/exceptions/for_object_exception.dart';

///
/// verify_email_error.dart
/// bishopric-assistant
///
/// Created by Po on 1/7/22
/// Copyright 2022 Po. All rights reserved.
///

class VerifyEmailError extends ForObjectException {
  VerifyEmailError() : super("Please verify email address");
}
