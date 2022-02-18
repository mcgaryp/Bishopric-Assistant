import 'package:models/models/account.dart';

import 'mock_contact.dart';
import 'mock_credentials.dart';
import 'mock_name.dart';

///
/// mock_account.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 porter. All rights reserved.
///

class MockAccount {
  late Account account;

  MockAccount({
    AccountID? id,
    Name? name,
    Contact? contact,
    Credentials? credentials,
  }) {
    account = Account(
      id: id,
      name: name ?? MockName().name,
      contact: contact ?? MockContact().contact,
      credentials: credentials ?? MockCredentials().credentials,
    );
  }
}

class MockAccountID {
  static String mockID = "Mock account ID";
  late AccountID id;

  MockAccountID({String? id}) {
    this.id = AccountID(id ?? mockID);
  }
}
