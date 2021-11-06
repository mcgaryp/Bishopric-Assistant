import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final Collections collectionPath;
  final String? Function(List<Object?>?)? validator;
  final Function(List) onChange;

  const FirebaseMultiSelectField(this.label,
      {required this.collectionPath,
      required this.onChange,
      this.validator,
      Key? key})
      : super(key: key);

  @override
  _FirebaseMultiSelectFieldState createState() =>
      _FirebaseMultiSelectFieldState();
}

class _FirebaseMultiSelectFieldState extends State<FirebaseMultiSelectField> {
  List<MultiSelectItem<FirestoreDocument>> _items = [];

  var _selected = [];

  @override
  void initState() {
    _getMenuItems();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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

  Future<void> _getMenuItems() async {
    final snapshot =
        await OldFirestoreHelper.reference(widget.collectionPath.string).get();
    List<QueryDocumentSnapshot> data =
        OldFirestoreHelper.listQuerySnap(snapshot);

    if (this.mounted) {
      setState(() {
        // Convert Data to Database model
        List<FirestoreDocument> models = data
            .map<FirestoreDocument>((snap) => FirestoreDocument.instance(
                int.parse(snap.id), snap[FirestoreDocument.namePath]))
            .toList();

        // Save model as a list of MultiSelectItem
        _items = models
            .map<MultiSelectItem<FirestoreDocument>>((model) =>
                MultiSelectItem<FirestoreDocument>(model, model.name))
            .toList();
      });
    }
  }
}
