import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mailto/mailto.dart';
import 'package:the_assistant/firebase/repositories/repositories.dart';
import 'package:the_assistant/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// $NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/31/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class BugReportPage extends StatefulWidget {
  @override
  State<BugReportPage> createState() => _BugReportPageState();
}

class _BugReportPageState extends State<BugReportPage> {
  TextEditingController titleControl = TextEditingController();
  TextEditingController descriptionControl = TextEditingController();
  TextEditingController replicationControl = TextEditingController();
  List<File> _files = [];

  @override
  void initState() {
    if (kDebugMode) {
      titleControl.text = "Example Bug Report";
      descriptionControl.text = "There is a test bug that I was wondering to "
          "see if something is actually working or not...";
      replicationControl.text = "I currently have nothing to say about "
          "replicating it";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LightPage(
        child: Form(
            child: SingleChildScrollView(
      child: Column(children: [
        Text(sReportBug, style: smallTitle),
        Text(
          "We would love to hear feedback. Please let us know "
          "what you think can be improved on or if there is "
          "anything that has gone wrong when using The Assistant",
          style: subhead,
        ),
        // Title
        InputField.plain(
          sTitle,
          controller: titleControl,
        ),

        // Description
        InputField.plain(
          sDescription,
          controller: descriptionControl,
          maxLines: true,
        ),

        // How to Replicate
        InputField.plain(
          sHowToReplicate,
          controller: replicationControl,
          maxLines: true,
        ),

        // Media, Images, Video Footage
        Align(
          alignment: Alignment.centerRight,
          child: MediaPicker(
            onSelected: (List<File> files) {
              setState(() {
                _files = files;
              });
            },
          ),
        ),

        if (_files.isNotEmpty)
          Column(
              children: _files.map<Widget>((File file) {
            return ListTile(title: Text(file.path, style: body));
          }).toList()),

        // Save
        MyButton(
          label: sSend,
          onPressed: _onSend,
        ),
      ]),
    )));
  }

  void _onSend() async {
    try {
      BugReport report = BugReport(
        title: titleControl.text,
        description: descriptionControl.text,
        replication: replicationControl.text,
        attachments: _files,
      );

      FirestoreUtilRepository repository = FirestoreUtilRepository();

      String email = await repository.getIssuesEmail();

      Mailto mailtoLink =
          Mailto(to: [email], subject: report.title, body: report.reportBody);
      await launch("$mailtoLink");
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }
  }
}

class BugReport {
  final String title;
  final String _description;
  final String? _replication;
  final List<File> attachments;

  BugReport({
    required this.title,
    required String description,
    String? replication,
    this.attachments = const [],
  })  : this._description = description,
        this._replication = replication;

  String get reportBody {
    if (_replication != null) {
      String str = """
## Description  
$_description
## How to Replicate  
$_replication
## Media
""";
      if (attachments.isEmpty) str += "No Media Presented";
      for (File file in attachments) {
        str += "${file.path}\n";
      }

      return str;
    }

    return _description;
  }
}
