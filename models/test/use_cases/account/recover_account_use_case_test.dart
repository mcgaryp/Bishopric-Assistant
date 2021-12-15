import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/models/account_domain/account_use_cases.dart';

import '../../mocks/account/mock_account_repository.dart';

///
/// recover_account_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Split into Two Use cases request and recover
class RecoverAccountUseCaseTest {
  static final Duration duration = Duration(seconds: 1);

  static void shouldReturnAccountWhenValidUsernameGiven() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    DefaultRecoverAccountUseCase recoverAccount =
        DefaultRecoverAccountUseCase(accountRepository);
    Account account = accountRepository.accounts.first;
    String usernameOrPhone = account.credentials.username;
    throw UnimplementedError();
    // Result result = await recoverAccount.execute(usernameOrPhone);
    // expect(result.isValue, true);
    // expect(result.isError, false);
    // expect(result.asError, null);
    // expect(result.asValue!.value, account.credentials);
  }

  static void shouldReturnAccountWhenValidPhoneGiven() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    DefaultRecoverAccountUseCase recoverAccount =
        DefaultRecoverAccountUseCase(accountRepository);
    Account account = accountRepository.accounts.first;
    String usernameOrPhone = account.contact.phone;
    throw UnimplementedError();
    // Result result = await recoverAccount.execute(usernameOrPhone);
    // if (result.isValue) {
    //   expect(result.isValue, true);
    //   expect(result.isError, false);
    //   expect(result.asError, null);
    //   expect(result.asValue!.value, account);
    // } else {
    //   expect(result.isValue, false);
    //   expect(result.isError, true);
    //   expect(result.asValue, null);
    //   expect(result.asError!.error, false);
    // }
  }

  static void shouldReturnAccountNotFoundErrorWhenInvalidUsernameGiven() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    DefaultRecoverAccountUseCase recoverAccount =
        DefaultRecoverAccountUseCase(accountRepository);
    String usernameOrPhone = "Bad Username";
    throw UnimplementedError();
    // Result result = await recoverAccount.execute(usernameOrPhone);
    // expect(result.isValue, false);
    // expect(result.isError, true);
    // expect(result.asError!.error.toString(), AccountNotFoundError().toString());
    // expect(result.asValue, null);
  }

  static void shouldReturnAccountNotFoundErrorWhenInvalidPhoneGiven() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    DefaultRecoverAccountUseCase recoverAccount =
        DefaultRecoverAccountUseCase(accountRepository);
    String usernameOrPhone = "Bad Phone";
    throw UnimplementedError();
    // Result result = await recoverAccount.execute(usernameOrPhone);
    // expect(result.isValue, false);
    // expect(result.isError, true);
    // expect(result.asError!.error.toString(), AccountNotFoundError().toString());
    // expect(result.asValue, null);
  }
}

runRecoverAccountUseCaseTest() {
  group("Recover Account", () {
    test(
        "should return account when valid username is given with valid secondary authentication",
        RecoverAccountUseCaseTest.shouldReturnAccountWhenValidUsernameGiven);
    test(
        "should return account when valid phone is given with valid secondary authentication",
        RecoverAccountUseCaseTest.shouldReturnAccountWhenValidPhoneGiven);
    test(
        "should return Account Not Found Error when invalid username given",
        RecoverAccountUseCaseTest
            .shouldReturnAccountNotFoundErrorWhenInvalidUsernameGiven);
    test(
        "should return Account Not Found Error when invalid phone given",
        RecoverAccountUseCaseTest
            .shouldReturnAccountNotFoundErrorWhenInvalidPhoneGiven);
  });
}
