import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
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
}
