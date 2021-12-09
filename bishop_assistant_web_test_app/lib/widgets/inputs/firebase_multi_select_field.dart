import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

///
/// firebase_multi_select_field.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class FirebaseMultiSelectField extends StatefulWidget {
  final String label;
  final String? Function(List<Object?>?)? validator;
  final Function(List) onChange;

  const FirebaseMultiSelectField(this.label,
      {required this.onChange, this.validator, Key? key})
      : super(key: key);

  @override
  _FirebaseMultiSelectFieldState createState() =>
      _FirebaseMultiSelectFieldState();
}

class _FirebaseMultiSelectFieldState extends State<FirebaseMultiSelectField> {
  List<MultiSelectItem> _items = [];
  var _selected = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: Container(
        decoration: darkBorderBox,
        child: Column(
          children: <Widget>[
            MultiSelectBottomSheetField(
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                color: darkText,
              ),
              decoration: invisibleBox,
              selectedColor: darkPrimary,
              backgroundColor: darkPrimary,
              checkColor: light,
              unselectedColor: light,
              searchTextStyle: bodyLight,
              itemsTextStyle: bodyLight,
              selectedItemsTextStyle: bodyLight,
              listType: MultiSelectListType.LIST,
              searchable: true,
              buttonText: Text(widget.label, style: bodyDark),
              title: Text(widget.label, style: bodyLight),
              items: _items,
              onConfirm: (values) {
                _selected = values;
                widget.onChange(_selected);
              },
              confirmText: Text(
                "Confirm",
                style: bodyLight,
              ),
              cancelText: Text(
                "Cancel",
                style: bodyLight,
              ),
              searchHintStyle: bodyLight,
              closeSearchIcon: Icon(Icons.close, color: light),
              searchIcon: Icon(Icons.search, color: light),
              chipDisplay: MultiSelectChipDisplay(
                onTap: (value) {
                  setState(() {
                    _selected.remove(value);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
