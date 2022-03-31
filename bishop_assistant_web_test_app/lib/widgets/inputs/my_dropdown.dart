import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// my_dropdown.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class MyDropdown extends StatefulWidget {
  final String hint;
  final bool isInput;
  final double? padding;
  final String? Function(dynamic)? validator;
  final List<DropdownMenuItem<int>> collection;
  final void Function(int?)? onchange;
  final int? initialValue;

  const MyDropdown({
    Key? key,
    this.hint = "",
    this.initialValue,
    this.isInput = true,
    this.onchange,
    this.validator,
    this.collection = const [DropdownMenuItem<int>(value: -1, child: Text(""))],
    double? padding,
  })  : padding = padding != null
            ? padding
            : isInput
                ? padding8
                : padding16,
        super(key: key);

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  int? dropdownValue;
  List<DropdownMenuItem<int>> collection = [];

  @override
  void initState() {
    Set<DropdownMenuItem<int>> collectionSet = widget.collection.toSet();
    collection = collectionSet.toList();

    if (dropdownValue != null && dropdownValue! >= collection.length)
      dropdownValue = null;
    dropdownValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.padding!),
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
            style: body,

            // hint: Text(widget.hint, style: bodyDark),
          ),
        ],
      ),
    );
  }

  void _onChanged(newValue) {
    if (this.mounted) {
      setState(() {
        dropdownValue = newValue;
      });
      if (widget.onchange != null) widget.onchange!(newValue);
    }
  }

  InputDecoration _floating() {
    return InputDecoration(
      labelText: widget.hint,
      contentPadding: EdgeInsets.symmetric(horizontal: padding16),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: errorRedInputBorder,
      disabledBorder: InputBorder.none,
      errorStyle: calloutDark,
      hintText: widget.hint,
      hintStyle: captionDark,
      labelStyle: subhead,
    );
  }

  InputDecoration _border() {
    return InputDecoration(
        labelText: widget.hint,
        focusedBorder: lightPrimaryInputBorder,
        enabledBorder: darkPrimaryInputBorder,
        errorBorder: errorRedInputBorder,
        hintText: widget.hint,
        hintStyle: bodyDark,
        labelStyle: subhead);
  }
}
