///
/// delete_account_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class DeleteAccountUseCaseTest {
  static void shouldReturnValidResultWhenGivenValidAccountID() async {
    // MockAccountRepository accountRepository = MockAccountRepository();
    // DefaultDeleteAccountUseCase deleteAccount =
    //     DefaultDeleteAccountUseCase(accountRepository);
    // AccountID accountID = accountRepository.accounts.first.id;
    // await deleteAccount.execute(accountID, accountID);
    // throw UnimplementedError();
  }

  static void
      shouldReturnAccountNotFoundErrorWhenGivenInvalidAccountID() async {
    // MockAccountRepository accountRepository = MockAccountRepository();
    // DefaultDeleteAccountUseCase deleteAccount =
    //     DefaultDeleteAccountUseCase(accountRepository);
    // AccountID accountID = AccountID("Bad ID");
    // await deleteAccount.execute(accountID, accountID);
    // throw UnimplementedError();
  }
}

runDeleteAccountUseCaseTests() {
  // group("Delete Account", () {
  //   test(
  //       "should return valid result when given valid account ID",
  //       DeleteAccountUseCaseTest
  //           .shouldReturnValidResultWhenGivenValidAccountID);
  //   test(
  //       "should return account not found when invalid id given",
  //       DeleteAccountUseCaseTest
  //           .shouldReturnAccountNotFoundErrorWhenGivenInvalidAccountID);
  // });
}
