import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

///
/// FirebaseDropDown.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

// Turn into a similar widget as the InputField.dart
class FirebaseDropDown extends StatefulWidget {
  final Collections collectionPath;
  final Document document;
  final String hint;
  final bool isInput;
  final String? Function(dynamic)? validator;
  final void Function(dynamic)? onchange;

  const FirebaseDropDown({required this.collectionPath,
    required this.document,
    this.hint = "",
    this.isInput = false,
    this.onchange,
    this.validator,
    Key? key})
      : super(key: key);

  @override
  _FirebaseDropDownState createState() => _FirebaseDropDownState();
}

class _FirebaseDropDownState extends State<FirebaseDropDown> {
  String? dropdownValue;
  List<DropdownMenuItem> collection = [
    DropdownMenuItem(value: "", child: Text(""))
  ];

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
  build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.isInput ? padding8 : padding16),
      child: Stack(
        children: [
          Container(
            height: 48,
            decoration: widget.isInput ? null : floatingLightBox,
          ),
          DropdownButtonFormField(
            decoration: widget.isInput ? _border() : _floating(),
            isExpanded: true,
            validator: widget.validator,
            value: dropdownValue,
            onChanged: _onChanged,
            items: collection,
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: darkText),
            style: bodyDark,
            // hint: Text(widget.hint, style: bodyDark),
          ),
        ],
      ),
    );
  }

  void _onChanged(newValue) {
    if (this.mounted) {
      setState(() {
        dropdownValue = newValue!;
      });
      if (widget.onchange != null) widget.onchange!(newValue);
    }
  }

  Future<void> _getMenuItems() async {
    final snapshot =
    await FirestoreHelper.reference(widget.collectionPath.string()).get();
    List<QueryDocumentSnapshot> data = FirestoreHelper.listQuerySnap(snapshot);

    if (this.mounted) {
      setState(() {
        collection = data
            .map<DropdownMenuItem>((e) =>
            DropdownMenuItem(
                value: e[widget.document.name],
                child: Text(e[widget.document.name])))
            .toList();
      });
    }
  }

  InputDecoration _floating() {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: padding16),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: errorRedInputBorder,
      disabledBorder: InputBorder.none,
      errorStyle: calloutLight,
      hintText: widget.hint,
      hintStyle: captionLight,
      labelStyle: bodyDark,
    );
  }

  InputDecoration _border() {
    return InputDecoration(
      focusedBorder: lightPrimaryInputBorder,
      enabledBorder: darkPrimaryInputBorder,
      errorBorder: errorRedInputBorder,
      hintText: widget.hint,
      hintStyle: bodyDark,
      // labelText: widget.label,
      // labelStyle: bodyDark
    );
  }
}
