// ignore_for_file: prefer_function_declarations_over_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;

  User? getUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool isLoggedIn() {
    try {
      if (_auth.currentUser != null) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> deleteUser() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser?.delete();
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> logout() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();
        debugPrint('Signed Out');
        return true;
      }
    } catch (e) {
      debugPrint('Unable to Sign Out. $e');
    }
    return false;
  }

  Future<bool> _signIn(AuthCredential authCreds) async {
    try {
      await _auth.signInWithCredential(authCreds);
      return true;
    } catch (e) {
      debugPrint('Unable To Sign In. $e');
    }
    return false;
  }

  Future<void> signInWithOTP(String smsCode) async {
    final AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await _signIn(authCreds);
  }

  Future<void> verifyPhone(String phoneNo) async {
    ConfirmationResult result = await _auth.signInWithPhoneNumber(phoneNo);
    verificationId = result.verificationId;
    debugPrint('Verification ID: $verificationId');
  }
}
