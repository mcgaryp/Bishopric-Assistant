import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// FirebaseDropDown.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

// TODO: Comment
class FirebaseDropDown extends StatefulWidget {
  final Collections collectionPath;
  final String hint;
  final bool isInput;
  final String? Function(dynamic)? validator;
  final void Function(int)? onchange;

  const FirebaseDropDown(
      {required this.collectionPath,
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
  int? dropdownValue;
  List<DropdownMenuItem<int>> collection = [
    DropdownMenuItem<int>(value: -1, child: Text(""))
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
        await OldFirestoreHelper.reference(widget.collectionPath.string).get();
    List<QueryDocumentSnapshot> data = OldFirestoreHelper.listQuerySnap(snapshot);

    if (this.mounted) {
      setState(() {
        collection = data
            .map<DropdownMenuItem<int>>((e) => DropdownMenuItem<int>(
                value: int.parse(e.id),
                child: Text(e[FirestoreDocument.namePath])))
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
