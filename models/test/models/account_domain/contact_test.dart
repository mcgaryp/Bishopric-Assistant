import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../mocks/account/mock_contact.dart';

///
/// contact_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class ContactTest with Test {
  static void shouldReturnEmailWithValidEmail() {
    Contact contact = MockContact().contact;
    String result = contact.email;
    expect(result, MockContact.mockEmail);
  }

  static void shouldReturnEmptyStringErrorWithInvalidEmail() {
    try {
      MockContact(email: "");
    } catch (result) {
      expect(result.toString(),
          EmptyStringError(forObject: "Contact Email").toString());
      return;
    }
    Test.fallthrough();
  }

  static void shouldReturnPhoneWithValidPhone() {
    Contact contact = MockContact().contact;
    String result = contact.phone;
    expect(result, MockContact.mockPhone);
  }

  static void shouldReturnEmptyStringErrorWithInvalidPhone() {
    try {
      MockContact(phone: "");
    } catch (result) {
      expect(result.toString(),
          EmptyStringError(forObject: "Contact Phone").toString());
      return;
    }
    Test.fallthrough();
  }
}

runContactTests() {
  group("Contact", () {
    test("should return valid email",
        ContactTest.shouldReturnEmailWithValidEmail);
    test("should return valid phone",
        ContactTest.shouldReturnPhoneWithValidPhone);
    test("should return empty string error from phone",
        ContactTest.shouldReturnEmptyStringErrorWithInvalidPhone);
    test("should return empty string error from email",
        ContactTest.shouldReturnEmptyStringErrorWithInvalidEmail);
  });
}
