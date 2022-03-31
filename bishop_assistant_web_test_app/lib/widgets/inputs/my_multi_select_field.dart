import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

///
/// my_multi_select_field.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class MyMultiSelectField<T> extends StatelessWidget {
  final String label;
  final Function(List<T>) onChange;
  final List<MultiSelectItem<T>> items;
  final List<T>? initialValues;

  const MyMultiSelectField(
    this.label, {
    this.initialValues,
    required this.onChange,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField<T>(
      initialValue: initialValues,
      items: items,
      title: Text(label),
      selectedColor: dark,
      decoration: darkBorderBox,
      buttonIcon: Icon(Icons.person),
      buttonText: Text(label),
      onConfirm: (results) {
        onChange(results);
      },
    );
  }
}
