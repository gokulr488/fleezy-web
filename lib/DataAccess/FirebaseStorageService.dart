import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageService {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final Reference ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List bytes) {
    try {
      return FirebaseStorage.instance.ref(destination).putData(bytes);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static UploadTask? uploadPickerRes(
      String folder, FilePickerResult? filePickerRes) {
    try {
      final String filePath =
          folder + basename(filePickerRes!.files.first.name);
      return FirebaseStorage.instance
          .ref(filePath)
          .putData(filePickerRes.files.first.bytes!);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
