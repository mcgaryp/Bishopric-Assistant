import 'package:models/models/account_domain/contact.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/16/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DBContact {
  static const String idKey = "Contact ID";
  static const String emailKey = "Contact email";
  static const String phoneKey = "Contact phone";

  String? email;
  String? phone;
  String? id;

  DBContact({this.id, this.email, this.phone});

  DBContact.fromMap(Map<String, dynamic> map)
      : this(
          id: map[idKey],
          email: map[emailKey],
          phone: map[phoneKey],
        );

  DBContact.fromContact(Contact contact)
      : this(email: contact.email, phone: contact.phone);

  Contact get toContact {
    if (email == null || phone == null)
      throw Exception("Unable to convert to Contact");
    return Contact(email: email!, phone: phone!);
  }

  Map<String, dynamic> get toMap => {
        idKey: id,
        emailKey: email,
        phoneKey: phone,
      };
}
