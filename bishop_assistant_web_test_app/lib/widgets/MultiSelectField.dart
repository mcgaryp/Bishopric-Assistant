import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

///
/// MultiSelectField.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class MultiSelectField extends StatelessWidget {
  final String label;
  const MultiSelectField(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _selectedMembers = [];

    List<Member> _items = [
      Member.bishopExample,
      Member.counselor1Example,
      Member.counselor2Example,
      Member.wardAssistantExecutiveSecretaryExample,
      Member.wardExecutiveSecretaryExample,
      Member.wardClerkExample,
      Member.assistantWardClerkExample,
      Member.assistantWardClerkExample,
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: MultiSelectChipField(
        title: Text(label, style: body2Style),
        items: _items
            .map((Member e) => MultiSelectItem(e.firstName, e.firstName))
            .toList(),
        onTap: (List<String?> values) {
          _selectedMembers = values;
          print(values);
        },
      ),
    );
  }
}
