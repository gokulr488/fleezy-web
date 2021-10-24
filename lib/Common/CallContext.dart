// ignore_for_file: always_specify_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CallContext {
  late String _message;
  bool isError = false;
  dynamic data;
  DocumentSnapshot? pageInfo;

  String get message => _message;

  void setError(String msg) {
    debugPrint(msg);
    _message = msg;
    isError = true;
  }

  void setSuccess(String msg) {
    debugPrint(msg);
    _message = msg;
    isError = false;
  }

  // void showSilentAlerts(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 2,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  void showConfirmationAlerts(BuildContext context) {}
}
