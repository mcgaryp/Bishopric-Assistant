import 'package:bishop_assistant_web_test_app/theme/decorations.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/inputs/input_field.dart';
import 'package:flutter/material.dart';
import 'package:models/shared/foundation.dart';

///
/// search_bar.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/15/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class SearchBar<T> extends StatefulWidget {
  final bool Function(T, String?) filter;
  final List<T> searchableItems;
  final Function(Result<List<T>>) onChange;

  const SearchBar(
      {required this.onChange,
      required this.filter,
      required this.searchableItems,
      Key? key})
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState<T>();
}

class _SearchBarState<T> extends State<SearchBar<T>> {
  final TextEditingController searchController = TextEditingController();
  FocusNode focus = FocusNode();
  Widget? leftIcon;
  Widget rightIcon = Container();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    rightIcon = Padding(
      padding: const EdgeInsets.only(right: padding16),
      child: searchIcon,
    );
    searchController.addListener(_onChange);
    focus.addListener(_onChangeFocus);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(_onChange);
    searchController.dispose();
    focus.removeListener(_onChangeFocus);
    focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: Container(
          decoration: floatingLightBox,
          child: Row(
            children: [
              leftIcon ?? Container(),
              Flexible(
                  child: InputField.plain(sSearch,
                      controller: searchController, focus: focus)),
              rightIcon
            ],
          )),
    );
  }

  void _search(String? searchStr) {
    List<T> lst = [];
    for (T item in widget.searchableItems)
      if (widget.filter(item, searchStr)) lst.add(item);
    if (lst.isEmpty) {
      widget.onChange(Result.error(ErrorDescription("No Matching Results")));
      return;
    }
    widget.onChange(Result.value(lst));
  }

  Widget get searchIcon => Icon(Icons.search);

  Widget get clearIcon => TextButton(
        child: Icon(Icons.clear),
        onPressed: searchController.clear,
        focusNode: focus,
        style: textButtonStyle,
      );

  void _onChange() {
    _search(searchController.text);
  }

  void _onChangeFocus() {
    if (focus.hasFocus) {
      leftIcon = Padding(
        padding: const EdgeInsets.only(left: padding16),
        child: searchIcon,
      );
      rightIcon = clearIcon;
    } else {
      leftIcon = null;
      rightIcon = Padding(
        padding: const EdgeInsets.only(right: padding16),
        child: searchIcon,
      );
    }
  }
}
