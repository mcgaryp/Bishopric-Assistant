import 'package:bishop_assistant_web_test_app/database/DatabaseModel.dart';
import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

///
/// FirebaseMultiSelectField.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class FirebaseMultiSelectField extends StatefulWidget {
  final String label;
  final Collections collectionPath;
  final Document document;
  const FirebaseMultiSelectField(this.label,
      {required this.collectionPath, required this.document, Key? key})
      : super(key: key);

  @override
  _FirebaseMultiSelectFieldState createState() =>
      _FirebaseMultiSelectFieldState();
}

class _FirebaseMultiSelectFieldState extends State<FirebaseMultiSelectField> {
  List<MultiSelectItem<DatabaseModel>> _items = [];

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
        decoration: inputOnLightDecoration,
        child: Column(
          children: <Widget>[
            MultiSelectBottomSheetField(
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                color: blackText,
              ),
              decoration: textButtonDecoration,
              selectedColor: darkAccent,
              backgroundColor: darkAccent,
              checkColor: white,
              unselectedColor: white,
              searchTextStyle: body2Style,
              itemsTextStyle: body2Style,
              selectedItemsTextStyle: body2Style,
              listType: MultiSelectListType.LIST,
              searchable: true,
              buttonText: Text(widget.label, style: bodyStyle),
              title: Text(widget.label, style: body2Style),
              items: _items,
              onConfirm: (values) {
                _selected = values;
              },
              confirmText: Text(
                "Confirm",
                style: body2Style,
              ),
              cancelText: Text(
                "Cancel",
                style: body2Style,
              ),
              searchHintStyle: body2Style,
              closeSearchIcon: Icon(Icons.close, color: white),
              searchIcon: Icon(Icons.search, color: white),
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
        await FirestoreHelper.reference(widget.collectionPath.string()).get();
    List<QueryDocumentSnapshot> data = FirestoreHelper.listQuerySnap(snapshot);

    if (this.mounted) {
      setState(() {
        // Convert Data to Database model
        List<DatabaseModel> models = data
            .map<DatabaseModel>((snap) => widget.collectionPath
                .instance(int.parse(snap.id), snap[widget.document.name]))
            .toList();

        // Save model as a list of MultiSelectItem
        _items = models
            .map<MultiSelectItem<DatabaseModel>>(
                (model) => MultiSelectItem<DatabaseModel>(model, model.name))
            .toList();
      });
    }
  }
}
