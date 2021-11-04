import 'package:models/shared/foundation.dart';

///
/// contact.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

/// [Contact] is a class that maintains and verifies the correct use of contact
///   information of the Account
class Contact extends ValueObject<Contact> {
  /// [_email] holds the physical email address of the account. Not meant to be
  ///   mutable
  late final String _email;

  /// [_phone] holds the physical phone number of the account. Not meant to be
  ///   mutable
  late final String _phone;

  /// [Contact] Constructor to create a specific contact
  Contact({required String email, required String phone})
      : super.decode({"phone": phone, "email": email}) {
    __phone = phone;
    __email = email;
  }

  /// [__email] setter to ensure that the email is not empty string
  set __email(String email) {
    if (email.isEmpty) throw EmptyStringError(forObject: "Contact Email");
    _email = email;
  }

  /// [__phone] setter to ensure that the phone number is not an empty string
  set __phone(String phone) {
    if (phone.isEmpty) throw EmptyStringError(forObject: "Contact Phone");
    _phone = phone;
  }

  /// [phone] public getter to access the phone number
  String get phone => _phone;

  /// [email] public getter to access the email address
  String get email => _email;

  @override
  bool sameValueAs(Contact other) {
    return other.email == this.email && this.phone == other.phone;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Contact) return false;
    return sameValueAs(other as Contact);
  }

  @override
  Map<String, dynamic> toJson() => {"phone": phone, "email": email};
}
