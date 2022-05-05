import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:the_assistant/firebase/firebase_instances.dart';

///
/// $NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 4/1/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FireStorageHelper {
  static final FirebaseStorage _storage = FirebaseInstances.storage;

  Future<bool> addFile(String path, File file) async {
    bool success = false;
    UploadTask task = _storage.ref(path).putFile(file);
    await task.then((TaskSnapshot snapshot) {
      if (snapshot.state == TaskState.success) success = true;
    });
    return success;
  }

  Future<String> findFileURL(String path) async {
    return await _storage.ref(path).getDownloadURL();
  }
}
