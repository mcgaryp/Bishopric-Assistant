import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:the_assistant/widgets/widgets.dart';

///
/// $NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 4/1/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MediaPicker extends StatefulWidget {
  final void Function(List<File>)? onSelected;

  const MediaPicker({Key? key, this.onSelected}) : super(key: key);

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  List<File> files = [];
  late void Function(List<File>) onSelected;

  @override
  void initState() {
    onSelected = (List<File> files) {};
    if (widget.onSelected != null) onSelected = widget.onSelected!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb)
      return Center(
          child: Error404(
              msg: "Selecting file NOT Supported at this time from Web"));
    return MyButton(
      isExpanded: false,
      label: "Select File",
      onPressed: _selectFile,
    );
  }

  void _selectFile() async {
    try {
      // Lets the user pick one file; files with any file extension can be selected
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

      // The result will be null, if the user aborted the dialog
      if (result != null) {
        throw UnimplementedError(
            "File selection not supported on ${Platform.localeName}");
      }
    } catch (e) {
      MyToast.toastError(e);
      if (kDebugMode) print(e);
    }
  }
}
