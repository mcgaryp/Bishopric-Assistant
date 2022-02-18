import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/account_not_found_error.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/account/mock_account_repository.dart';
import '../../../mocks/account/mock_contact.dart';
import '../../../mocks/account/mock_credentials.dart';

///
/// recover_account_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Is This useCase needed?
class RecoverAccountUseCaseTest {
  // REPO FUNCTION CALLS
  // - account repo
  //   - calls findByUsername or Phone or Email
  static void verifyFunctionRepoCalls() async {
    MockAccountRepository mockRepo = MockAccountRepository();
    RecoverAccountUseCase useCase = DefaultRecoverAccountUseCase(mockRepo);

    await useCase.execute(MockAccount().account.contact.phone);
    await useCase.execute(MockAccount().account.contact.email);
    await useCase.execute(MockAccount().account.credentials.username);

    expect(mockRepo.activateFlag, false);

    expect(mockRepo.findFlag, false);

    expect(mockRepo.findByEmailFlag, true);

    expect(mockRepo.findByPhoneFlag, true);

    expect(mockRepo.findByUsernameFlag, true);

    expect(mockRepo.findStreamedFlag, false);

    expect(mockRepo.insertFlag, false);

    expect(mockRepo.loginFlag, false);

    expect(mockRepo.logoutFlag, false);

    expect(mockRepo.removeFlag, false);

    expect(mockRepo.updateFlag, false);
  }

  // VERIFY PERMISSIONS
  static void verifyPermissions() async {
    // There currently are no permission verifications at this time
  }

  // VERIFY RESULTS
  // - Success returns the contact information of the account
  // - Failure to find account throws account not found error
  static void verifyResults() async {
    // Expected
    MockAccountRepository mockRepo = MockAccountRepository();
    RecoverAccountUseCase useCase = DefaultRecoverAccountUseCase(mockRepo);

    Contact contact =
        await useCase.execute(MockAccount().account.contact.phone);
    expect(contact == MockContact().contact, true);
    contact = await useCase.execute(MockAccount().account.contact.email);
    expect(contact == MockContact().contact, true);
    contact = await useCase.execute(MockAccount().account.credentials.username);
    expect(contact == MockContact().contact, true);

    // Cannot find with username
    try {
      await useCase.execute(
          MockAccount(contact: MockContact(phone: "123456789").contact)
              .account
              .contact
              .phone);
      Test.fallthrough(
          notes: "Failed to notify of account not found with a phone number");
    } catch (error) {
      expect(error.toString(), AccountNotFoundError().toString());
    }

    // Cannot find with phone
    try {
      await useCase.execute(MockAccount(
              contact: MockContact(email: "Not your email@me.com").contact)
          .account
          .contact
          .email);
      Test.fallthrough(
          notes: "Failed to notify of account not found with a phone number");
    } catch (error) {
      expect(error.toString(), AccountNotFoundError().toString());
    }

    // Cannot find with email
    try {
      await useCase.execute(MockAccount(
              credentials:
                  MockCredentials(username: "not your user name").credentials)
          .account
          .credentials
          .username);
      Test.fallthrough(
          notes: "Failed to notify of account not found with a phone number");
    } catch (error) {
      expect(error.toString(), AccountNotFoundError().toString());
    }
  }
}

runRecoverAccountUseCaseTest() {
  group("Recover Account", () {
    test("verify repo function calls",
        RecoverAccountUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions", RecoverAccountUseCaseTest.verifyPermissions);
    test("verify results", RecoverAccountUseCaseTest.verifyResults);
  });
}
