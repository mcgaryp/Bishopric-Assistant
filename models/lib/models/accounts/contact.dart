import 'package:models/shared/exceptions.dart';
import 'package:models/shared/value_object.dart';

///
/// contact.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

class Contact extends ValueObject<Contact> {
  late final String _email;
  late final String _phone;

  Contact({required String email, required String phone})
      : super.decode({"phone": phone, "email": email}) {
    __phone = phone;
    __email = email;
  }

  set __email(String email) {
    if (email.isEmpty) throw EmptyStringError();
    _email = email;
  }

  set __phone(String phone) {
    if (phone.isEmpty) throw EmptyStringError();
    _phone = phone;
  }

  String get phone => _phone;

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
