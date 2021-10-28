import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy_web/Common/Alerts.dart';
import 'package:fleezy_web/Common/AppData.dart';
import 'package:fleezy_web/Common/Authentication.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/DataAccess/DAOs/Company.dart';
import 'package:fleezy_web/DataAccess/DAOs/Roles.dart';
import 'package:fleezy_web/DataModels/ModelCompany.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';
import 'package:fleezy_web/Screens/HomePage/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginController {
  late Stream<User?> userStream;
  late StreamSubscription<User?> userSubscription;

  late Stream<String> messages;
  StreamController<String> streamCtrl = StreamController<String>();

  Authentication auth = Authentication();
  ModelUser? user = ModelUser(
      roleName: Constants.DRIVER,
      phoneNumber: '',
      companyId: <String>[],
      state: Constants.INACTIVE);
  late String phoneNo;
  late String otp;
  bool showSpinner = false;
  bool verified = false;
  bool disableButton = false;

  void initListener() {
    userStream = FirebaseAuth.instance.authStateChanges();
    messages = streamCtrl.stream;
  }

  Future<void> onVerificationCompleted(BuildContext context) async {
    Provider.of<AppData>(context, listen: false).setUser(user);
    if (user?.uid == null) {
      user?.uid = Authentication().getUser()?.uid;
      await Roles().updateRole(user);
    }

    // if (user.roleName != Constants.ADMIN) {
    //   Provider.of<UiState>(context, listen: false).setIsAdmin(isAdmin: false);
    // }
    CallContext callContext =
        await Company().getCompanyById(user!.companyId.first);
    if (!callContext.isError) {
      Provider.of<AppData>(context, listen: false)
          .setSelectedCompany(callContext.data);
    }
    await Navigator.pushReplacementNamed(context, HomeScreen.id);
    await streamCtrl.close();
  }

  Future<void> onButtonPressed(BuildContext context) async {
    if (disableButton) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    if (phoneNo.length != 13) {
      showErrorAlert(context, 'Invalid Phone Number');
      return;
    }
    try {
      verified ? await login() : await verify();
    } catch (e) {
      debugPrint(e.toString());
      showErrorAlert(context, 'Error Logging In');
    }
  }

  Future<void> login() async {
    streamCtrl.add('Logging In...');
    await auth.signInWithOTP(otp);
  }

  Future<void> verify() async {
    streamCtrl.add('Gathering Account Info...');
    user = await Roles().verifyUser(phoneNo);
    if (user == null) {
      streamCtrl.add('This Phone Number is not Registered');
      return;
    } else if (user?.state != Constants.ACTIVE) {
      streamCtrl.add('This Phone Number is ${user?.state}');
      return;
    }
    auth.verifyPhone(phoneNo);
    streamCtrl.add('Verifying, Enter your OTP');
    verified = true;
  }

  void dispose() {
    userSubscription.cancel();
  }
}
