import 'package:models/models/account.dart';

///
/// mock_contact.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class MockContact {
  static final String mockEmail = "mock@me.com";
  static final String mockPhone = "1234567890";

  late final Contact contact;

  MockContact({String? email, String? phone}) {
    contact = Contact(email: email ?? mockEmail, phone: phone ?? mockPhone);
  }
}
