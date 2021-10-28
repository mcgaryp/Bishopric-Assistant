import 'package:flutter_test/flutter_test.dart';

import 'account/authenticate_account_use_case_test.dart';
import 'account/change_contact_use_case_test.dart';
import 'account/change_password_use_case_test.dart';
import 'account/confirm_pin_use_case_test.dart';
import 'account/create_account_use_case_test.dart';
import 'account/delete_account_use_case_test.dart';
import 'account/recover_account_use_case_test.dart';

///
/// use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

runUseCaseTests() {
  group("Use Case Tests", () {
    group("Account Tests", () {
      runAuthenticateAccountTests();
      runChangeContactTests();
      runChangePasswordUseCaseTests();
      runConfirmPinUseCaseTests();
      runCreateAccountUseCaseTests();
      runDeleteAccountUseCaseTests();
      runRecoverAccountUseCaseTest();
    });
  });
}
