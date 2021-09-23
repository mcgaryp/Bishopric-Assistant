import 'package:models/shared/exceptions.dart';

import '../extensions/string_extentions.dart';

///
/// functions.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

String checkCapitalization(String str) {
  if (str.isEmpty) throw EmptyString();
  if (str.isNotCapitalized) return str.capitalize;
  return str;
}
